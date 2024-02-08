/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        "mantine-primary": "#FF1744",
        "mantine-secondary": "#2979FF",
        "mantine-accent": "#FF9100",
        "mantine-dark": "#202020",
        "mantine-light": "#F5F5F5",
      },
    },
  },
  plugins: [],
};

