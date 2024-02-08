/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        red: {
          100: '#ffeeee',
          200: '#ffdddd',
          300: '#ffcccc',
          400: '#ffaaaa',
          500: '#ff8888',
          600: '#ff6666',
          700: '#ff4444',
          800: '#ff2222',
          900: '#ff0000',
        },
      },
    },
  },
  plugins: [],
};