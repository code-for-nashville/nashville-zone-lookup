import Vue from 'vue'
import Router from 'vue-router'
import NashvilleZoneLookupHome from '@/components/NashvilleZoneLookupHome'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'NashvilleZoneLookupHome',
      component: NashvilleZoneLookupHome
    }
  ]
})
