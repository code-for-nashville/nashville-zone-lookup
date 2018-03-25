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
    return this.client.get('/landusecategories')
  }

/* /landuses/?address="My Addresss" - Return an object:
 *  {
 *    zone: {
 *      code: "",
 *      description: "",
 *      category: "",
 *    },
 *    land_uses: [
 *      {
 *        category: "Residential",
 *        description: "Build a house for your family less than 50K sqft",
 *        condition_code: "P"  # Permitted by right
 *      },
 *      {
 *        category: "Residential",
 *        description: "Build a house for your family larger than 50K sqft",
 *        condition_code: "NP"  # Not permitted
 *      },
 *      ...
 *    ]
 *  }
 */
  getUsesForAddress (address) {
    return this.client.get('/landuses', { params: { address } })
  }
}

export default new ParcelApiClient('http://localhost:4000/api')
