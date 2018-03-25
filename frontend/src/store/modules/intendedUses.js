// import ParcelApiClient from '@/api/parcelApiClient'
import * as types from '../mutationTypes'

const state = {
  intendedUses: [],
  usesForAddress: []
}

export const getters = {
  intendedUses: state => state.intendedUses
}

export const actions = {
  fetchAllIntendedUses ({ commit }) {
    const mockUses = [
      'party',
      'party',
      'join us',
      'join us'
    ]

    commit(types.GET_INTENDED_USES_SUCCESS, mockUses)

    return mockUses
  },

  fetchUsesForAddress ({ commit }, address) {
    // return ParcelApiClient
      // .getUsesForAddress(address)
      // .then(resp => {
        // // TODO return uses extracted from repsonse
        // console.info(resp)
        // return []
      // })
    return Promise.resolve([
        { zoning_category: 'Industrial', zoning_description: 'do stuff in this zone' },
        { zoning_category: 'Industrial', zoning_description: 'do stuff in this zone' }
    ])
      .then(usesForAddress => commit(types.GET_USES_FOR_ADDRESS_SUCCESS, usesForAddress))
      .catch(err => console.error(err))
  }
}

const mutations = {
  [types.GET_USES_FOR_ADDRESS_SUCCESS] (state, usesForAddress) {
    state.usesForAddress = usesForAddress
  },
  [types.GET_INTENDED_USES_SUCCESS] (state, intendedUses) {
    state.intendedUses = intendedUses
  },
  [types.GET_INTENDED_USES_FAILURE] (state) {
    state.intendedUses = []
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
