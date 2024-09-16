module.exports = {
  content: [
    './app/views/**/*.{html,erb,haml,slim}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/assets/stylesheets/**/*.css',
    './app/assets/stylesheets/*.css',
    './node_modules/flowbite/**/*.js',
  ],
  theme: {
    // gap: {
    //   '12': '3rem', // Add this line
    // },
    extend: {
      gridTemplateColumns: {
        'custom-md': '1.5fr 2fr 1fr', // Custom grid definition
      },
    },
  },
  plugins: [
    require('flowbite/plugin')
  ],
}