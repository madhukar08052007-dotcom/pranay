# pranay

# AgriMind AI — AI-Powered Agriculture Crop Advisory Assistant

An enterprise-grade, multi-tenant agronomic intelligence platform powered by **Google Gemini 2.5 SDK**, **Node.js**, **Express**, **TypeScript**, **PostgreSQL**, and **React 18 (Vite + Tailwind CSS)**.

![AgriMind AI](https://img.shields.io/badge/Gemini%20AI-2.5%20Pro-emerald?style=for-the-badge&logo=google) ![TypeScript](https://img.shields.io/badge/TypeScript-ES2022-blue?style=for-the-badge&logo=typescript) ![React](https://img.shields.io/badge/React-18-cyan?style=for-the-badge&logo=react) ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue?style=for-the-badge&logo=postgresql)

---

## 🌟 Key Features

- 🌾 **Geospatial Field Telemetry Profiling**: Multi-parcel registration with soil chemistry (pH, N-P-K baselines, organic matter %), soil classification, and irrigation infrastructure tracking.
- 🤖 **Intelligent Agronomic Advisory Engine**: Powered by `@google/genai` SDK using `gemini-2.5-pro` with structured JSON schema outputs (`responseMimeType: "application/json"`) and Zod schema validations. Includes a resilient scientific agronomic fallback engine.
- 💧 **Dynamic Water & Evapotranspiration ($ET_c$) Scheduling**: Precision water requirement calculations tailored to growth stage, moisture retention, and microclimate forecasts.
- 🔬 **Integrated Pest & Disease Management (IPM)**: Organic, biological, and chemical protection strategies with Pre-Harvest Intervals (PHI).
- 📈 **Interactive Economic & Market Feasibility**: Cost breakdowns, breakeven yield calculations, and sensitivity analysis matrices under worst-case, expected, and best-case climate conditions.
- 📋 **Print-Ready Action Cards & Field Work Orders**: Offline-resilient, printable work orders for farm labor and field operators.
- 📊 **Advisory vs. Yield Comparison**: Differential analysis of AI target projections against recorded field yields across seasons.
- 🔒 **Multi-Tenant PostgreSQL Isolation**: JWT authentication with parameterized query security and tenant isolation rules.

---

## 🚀 Tech Stack

- **Frontend**: React 18, Vite, TypeScript, Tailwind CSS v4, Lucide React, TanStack React Query v5, React Hook Form, Zod.
- **Backend**: Node.js v20+, Express.js, TypeScript (`tsx` runtime), `@google/genai` SDK.
- **Database**: PostgreSQL (`pg` node-postgres) with parameterized transactions.
- **Security**: JWT authentication, `bcryptjs` password hashing, `helmet`, `express-rate-limit`, `cors`.

---

## ⚙️ Quick Start

### 1. Installation
```bash
npm install
```

### 2. Configure Environment Variables
Create or update `.env` in the root directory:
```env
PORT=5000
NODE_ENV=development
JWT_SECRET=agrimind_super_secret_jwt_key_2026

# Database Configuration
DATABASE_URL=postgres://postgres:postgres@localhost:5432/agrimind_db

# Google Gemini API Key
GEMINI_API_KEY=your_gemini_api_key_here
```

### 3. Run Development Server
```bash
npm run dev
```
Access the application at `http://localhost:5173`.

### 4. Build for Production
```bash
npm run build
```

---

## 📜 License
ISC
