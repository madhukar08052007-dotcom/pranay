/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        agri: {
          50: '#f0fdf4',
          100: '#dcfce7',
          200: '#bbf7d0',
          300: '#86efac',
          400: '#4ade80',
          500: '#22c55e',
          600: '#16a34a',
          700: '#15803d',
          800: '#166534',
          900: '#14532d',
          950: '#052e16',
        },
        earth: {
          50: '#faf6f0',
          100: '#f3e9dc',
          200: '#e5d3bd',
          300: '#d4b797',
          400: '#c09871',
          500: '#ab7e54',
          600: '#956543',
          700: '#794d37',
          800: '#644031',
          900: '#53362c',
          950: '#2e1c17',
        },
        harvest: {
          50: '#fffbeb',
          100: '#fef3c7',
          200: '#fde047',
          300: '#facc15',
          400: '#eab308',
          500: '#ca8a04',
          600: '#a16207',
          700: '#854d0e',
          800: '#713f12',
          900: '#58310e',
        }
      },
      fontFamily: {
        sans: ['Plus Jakarta Sans', 'Inter', 'system-ui', 'sans-serif'],
      },
      animation: {
        'pulse-glow': 'pulse-glow 3s infinite ease-in-out',
      },
      keyframes: {
        'pulse-glow': {
          '0%, 100%': { opacity: '1', filter: 'drop-shadow(0 0 15px rgba(34, 197, 94, 0.4))' },
          '50%': { opacity: '0.85', filter: 'drop-shadow(0 0 25px rgba(34, 197, 94, 0.7))' },
        },
      }
    },
  },
  plugins: [],
}
