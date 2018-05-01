# Nashville Zone Lookup Frontend
Vue.js frontend for Code for Nashville's Nashville Zone Lookup app.

## Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report

# run unit tests
npm run unit

# run e2e tests
npm run e2e

# run all tests
npm test
```

## Project Outline
For detailed explanation on how the project is structured, checkout the [vue.js project template guide](http://vuejs-templates.github.io/webpack/) and the [docs for vue-loader](http://vuejs.github.io/vue-loader).  This project also uses [`vue-router`](https://router.vuejs.org/en/) for minimal routing.

## Styles
We use [Bootstrap 4](http://getbootstrap.com/) via [Bootsrap Vue](https://bootstrap-vue.js.org).

[SCSS](http://sass-lang.com/guide) can be used the `<style>` sections of components by setting `<style lang="scss"`.  Global variables are stored in `src/style/`.

## Icons
This uses [`vue-fontawesome`](https://github.com/FortAwesome/vue-fontawesome) for a Vue wrapper around the venerable [FontAwesome]() project.  Most importantly, this enables importing individual icons rather than the entire font collection using its `import faCoffee from '@fortawesome/fontawesome-free-solid/faCoffee'` syntax.

## Bug Tracking
Because it's nice and free for open source projects, we use [BugSnag](app.bugsnag.com/code-for-nashville/nashville-zone-lookup) to track frontend errors.  Contact one of the repository owners for access.
