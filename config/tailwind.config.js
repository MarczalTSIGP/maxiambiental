module.exports = {
    content: [
        './public/*.html',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js',
        './app/views/**/*.{erb,haml,html,slim}',
        './app/inputs/**/*.rb',
        './app/components/**/*',
        './config/initializers/*.rb',
    ],
    theme: {
        extend: {
            fontFamily: {},
        },
    },
    plugins: [
        require('@tailwindcss/forms'),
        require('@tailwindcss/typography'),
        require('@tailwindcss/container-queries'),
    ],
};
