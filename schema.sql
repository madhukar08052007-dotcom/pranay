-- Production PostgreSQL Schema for AI-Powered Agriculture Crop Advisory Assistant

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Clean teardown for migrations
DROP TABLE IF EXISTS economic_analyses CASCADE;
DROP TABLE IF EXISTS advisory_schedules CASCADE;
DROP TABLE IF EXISTS advisories CASCADE;
DROP TABLE IF EXISTS field_history CASCADE;
DROP TABLE IF EXISTS fields CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Users Table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    organization_name VARCHAR(200),
    preferred_unit VARCHAR(10) DEFAULT 'METRIC' CHECK (preferred_unit IN ('METRIC', 'IMPERIAL')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Fields Table
CREATE TABLE fields (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(150) NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    area_size DECIMAL(10, 2) NOT NULL CHECK (area_size > 0),
    area_unit VARCHAR(10) DEFAULT 'ACRES' CHECK (area_unit IN ('ACRES', 'HECTARES')),
    soil_type VARCHAR(50) NOT NULL, -- e.g., Sandy Loam, Clay Loam, Silt, Peat
    soil_ph DECIMAL(4, 2) CHECK (soil_ph BETWEEN 0.0 AND 14.0),
    nitrogen_level_ppm DECIMAL(8, 2),
    phosphorus_level_ppm DECIMAL(8, 2),
    potassium_level_ppm DECIMAL(8, 2),
    organic_matter_percentage DECIMAL(5, 2) CHECK (organic_matter_percentage BETWEEN 0.0 AND 100.0),
    irrigation_system VARCHAR(50) NOT NULL CHECK (irrigation_system IN ('DRIP', 'CENTER_PIVOT', 'FLOOD', 'MICRO_SPRINKLER', 'RAIN_FED')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Historical Crop Records
CREATE TABLE field_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    field_id UUID NOT NULL REFERENCES fields(id) ON DELETE CASCADE,
    year INT NOT NULL CHECK (year BETWEEN 1900 AND 2100),
    season VARCHAR(20) NOT NULL,
    crop_planted VARCHAR(100) NOT NULL,
    yield_amount DECIMAL(10, 2),
    yield_unit VARCHAR(20),
    notable_disease_issues TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Generated Advisories
CREATE TABLE advisories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    field_id UUID NOT NULL REFERENCES fields(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    strategy VARCHAR(50) NOT NULL,
    season VARCHAR(30) NOT NULL,
    optimization_metric VARCHAR(50) NOT NULL,
    allocated_budget DECIMAL(12, 2) NOT NULL,
    selected_crop VARCHAR(100) NOT NULL,
    recommended_cultivar VARCHAR(100) NOT NULL,
    planting_window_start DATE NOT NULL,
    planting_window_end DATE NOT NULL,
    expected_harvest_window_start DATE NOT NULL,
    expected_harvest_window_end DATE NOT NULL,
    overall_risk_rating VARCHAR(20) CHECK (overall_risk_rating IN ('LOW', 'MODERATE', 'HIGH', 'SEVERE')),
    summary_analysis TEXT NOT NULL,
    raw_ai_payload JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Advisory Execution Schedules (Fertigation, Irrigation, Pest Controls)
CREATE TABLE advisory_schedules (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    advisory_id UUID NOT NULL REFERENCES advisories(id) ON DELETE CASCADE,
    stage_name VARCHAR(100) NOT NULL, -- e.g., 'Pre-Sowing', 'Vegetative V4', 'Flowering'
    days_after_planting_start INT NOT NULL,
    days_after_planting_end INT NOT NULL,
    action_category VARCHAR(30) NOT NULL CHECK (action_category IN ('NUTRIENT', 'WATER', 'PEST_CONTROL', 'CULTIVATION')),
    instruction TEXT NOT NULL,
    target_chemical_or_input VARCHAR(150),
    recommended_rate VARCHAR(100), -- e.g., '50 kg/ha', '2.5 L/acre'
    safety_interval_days INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Economic Analysis & Margin Forecasts
CREATE TABLE economic_analyses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    advisory_id UUID NOT NULL REFERENCES advisories(id) ON DELETE CASCADE,
    total_estimated_costs DECIMAL(12, 2) NOT NULL,
    projected_minimum_revenue DECIMAL(12, 2) NOT NULL,
    projected_optimal_revenue DECIMAL(12, 2) NOT NULL,
    breakeven_yield_per_unit DECIMAL(10, 2) NOT NULL,
    projected_roi_percentage DECIMAL(6, 2) NOT NULL,
    cost_breakdown JSONB NOT NULL, -- Detailed sub-allocations (seeds, labor, fuel, inputs)
    risk_factors JSONB NOT NULL,    -- Array of strings identifying financial exposure
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Performance Indexes
CREATE INDEX idx_fields_user_id ON fields(user_id);
CREATE INDEX idx_advisories_field_id ON advisories(field_id);
CREATE INDEX idx_advisories_user_id ON advisories(user_id);
CREATE INDEX idx_schedules_advisory_id ON advisory_schedules(advisory_id);
CREATE INDEX idx_economics_advisory_id ON economic_analyses(advisory_id);
