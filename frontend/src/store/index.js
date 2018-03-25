import Vue from 'vue'
import Vuex from 'vuex'
import parcel from './modules/parcel'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
  modules: {
    parcel
  },
  strict: debug
})
