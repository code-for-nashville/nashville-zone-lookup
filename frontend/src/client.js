import axios from 'axios'

class ParcelApiClient {
  constructor (baseUrl) {
    this.client = axios.create({
      baseURL: baseUrl,
      headers: {'Accept': 'application/json'},
      timeout: 5000
    })
  }

  getLandUseCategories () {
    return this.client.get('/landusecategories')
  }

  /* /landuses/?address=My%20Addresss schema:
  {
    "zone": {"code", "category", "description"},
    "land_uses": [
      {"category", "name", "condition": {"code", "info_link", "description", "category"}}
    ]
  }

  */
  getLandUseSummaryForAddress (address) {
    return this.client.get('/landuses', { params: { address } })
  }
}

export default new ParcelApiClient('http://localhost:4000/api')