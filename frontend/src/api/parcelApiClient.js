import axios from 'axios'

class ParcelApiClient {
  constructor (baseUrl) {
    this.client = axios.create({
      baseURL: baseUrl,
      headers: {'Accept': 'application/json'},
      timeout: 5000
    })
  }

  getAllIntendedUses () {
    return this.client.get('/intended-uses')
  }
}

export default new ParcelApiClient('http://localhost:4000/api')
