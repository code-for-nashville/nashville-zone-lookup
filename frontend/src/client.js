const APIROOT = process.env.NODE_ENV === 'production'
  ? '/api'
  : 'http://localhost:4000/api'

function getLandUseCategories () {
  return fetch(`${APIROOT}/landusecategories`)
}

function getLandUseSummaryForAddress (address) {
  return fetch(`${APIROOT}/landuses?address=${window.encodeURI(address)}`)
}

export default {
  getLandUseCategories,
  getLandUseSummaryForAddress
}
