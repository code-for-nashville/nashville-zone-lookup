import ParcelApiClient from '@/api/parcelApiClient'
import * as types from '../mutationTypes'

const state = {
  intendedUses: []
}

export const getters = {
  intendedUses: state => state.intendedUses
}

export const actions = {
  fetchAllIntendedUses ({ commit }) {
    ParcelApiClient
      .getAllIntendedUses()
      .then((response) => {
        const intendedUses = response.data['intended_uses']
        commit(types.GET_INTENDED_USES_SUCCESS, { intendedUses })
      })
      .catch((error) => {
        commit(types.GET_INTENDED_USES_FAILURE)
      })
  }
}

const mutations = {
  [types.GET_INTENDED_USES_SUCCESS] (state, { intendedUses }) {
    state.intendedUses = intendedUses
  },
  [types.GET_INTENDED_USES_FAILURE] (state) {
    state.intendedUses = []
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
