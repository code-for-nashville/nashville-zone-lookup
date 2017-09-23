import Vue from 'vue'
import Router from 'vue-router'
import ParcelHome from '@/components/ParcelHome'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'ParcelHome',
      component: ParcelHome
    }
  ]
})
