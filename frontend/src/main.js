// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'
import { Dropdown } from 'bootstrap-vue/es/components'
import App from './App'
import router from './router'
import bugsnag from 'bugsnag-js'
import bugsnagVue from 'bugsnag-vue'

if (process.env.NODE_ENV === 'production') {
  const bugsnagClient = bugsnag('28cc2de41c1613dd5edefe36f55df02b')
  bugsnagClient.use(bugsnagVue(Vue))
}

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})

Vue.use(BootstrapVue)
Vue.use(Dropdown)
