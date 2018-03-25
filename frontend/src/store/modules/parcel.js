import ParcelApiClient from '@/api/parcelApiClient'
import * as types from '../mutationTypes'

const state = {
  landUseCategories: [],
  landUseSummary: false
}

export const getters = {
  landUseCategories: state => state.landUseCategories
}

export const actions = {

  fetchLandUseCategories ({ commit }) {
    return ParcelApiClient.getLandUseCategories()
      .then(resp => commit(types.GET_LAND_USE_CATEGORIES_SUCCESS, resp.data))
  },

  fetchLandUseSummaryForAddress ({ commit }, address) {
    return ParcelApiClient
      .getLandUseSummaryForAddress(address)
      .then(resp => resp.data)
      .then(landUseSummary => commit(types.GET_LAND_USE_SUMMARY_FOR_ADDRESS_SUCCESS, landUseSummary))
      .catch(err => console.error(err))
  }
}

const mutations = {
  [types.GET_LAND_USE_SUMMARY_FOR_ADDRESS_SUCCESS] (state, landUseSummary) {
    state.landUseSummary = landUseSummary
  },
  [types.GET_LAND_USE_CATEGORIES_SUCCESS] (state, landUseCategories) {
    state.landUseCategories = landUseCategories
  },
  [types.GET_LAND_USE_CATEGORIES_FAILURE] (state) {
    state.landUseCategories = []
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
