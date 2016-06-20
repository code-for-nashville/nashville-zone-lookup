'use strict'

// Set a minimum length before we start pinging the address service
// to avoid spamming it.
const ADDRESS_RESULT_CLASS = 'address-result',
      DEFAULT_ERROR_MESSAGE = 'We\'re having trouble getting addresses right now. If you believe this is a serious issue, please email shenfieldmax@gmail.com',
      MINIMUM_ADDRESS_SEARCH_LENGTH = 4,
      MAX_LOCATIONS_DISPLAYED = 5,
      SPATIAL_REFERENCE = {"wkid":102100,"latestWkid":3857},
      FIND_ADDRESS_ENDPOINT = 'http://maps.nashville.gov/arcgis/rest/services/Locators/LocNashComp/GeocodeServer/findAddressCandidates?outSR=' +
        encodeURIComponent(SPATIAL_REFERENCE) + '&maxLocations=' + MAX_LOCATIONS_DISPLAYED + '&f=json',
      GET_PARCEL_DATA_ENDPOINT = 'http://maps.nashville.gov/arcgis/rest/services/Cadastral/Cadastral_Layers/MapServer/4/query?' +
        'f=json&returnGeometry=true&spatialRel=esriSpatialRelIntersects&geometryType=esriGeometryPoint&inSR=102100&outFields=*&outSR=102100';

var addressInput = document.getElementById('address-input'),
    addressResults = document.getElementsByClassName('address-results')[0],
    introduction = document.getElementById('introduction'),
    template = document.getElementById('address-result-template');

addressInput.addEventListener('keyup', populateAddressSearchResults);

function populateAddressSearchResults(e) {
    if (e.target.value.length < MINIMUM_ADDRESS_SEARCH_LENGTH) {
        deleteAddressResults();
        return;
    }

    getAddressMatches(e.target.value)
      .then(function(response) {
        deleteAddressResults();
        response.candidates.forEach(function(candidate) {
          createAddressResult(candidate);
        });
      }).catch(function(nooo) {
          console.error(nooo);
          setError(DEFAULT_ERROR_MESSAGE);  
      });
}

function hideIntroduction() {
  introduction.setAttribute('hidden', '');
}

function getAddressMatches(value) {
  // the outSR parameter defines the version of the spatial reference returned
  return fetch(FIND_ADDRESS_ENDPOINT + '&SingleLine=' + encodeURIComponent(value))
    .then(function(response) {
      return response.json();
    });
}

function createAddressResult(candidate) {
    var clone,
        li = template.content.querySelector('li');
    
    li.dataset.x = candidate.location.x;
    li.dataset.y = candidate.location.y;
    li.textContent = candidate.address;
    clone = document.importNode(li, true);
    addressResults.appendChild(clone);
    // Adding event listeners won't work until you importNode and add it to the DOM
    clone.addEventListener('click', openLocationPage);
}


function deleteAddressResults() {
  let results = document.getElementsByClassName(ADDRESS_RESULT_CLASS);
 
  while (results.length) {
    results[0].remove();
  }
}

function openLocationPage(e) {
  var location = {
    x: +e.target.dataset.x,
    y: +e.target.dataset.y
  };

  hideIntroduction();
  getZoningInfoForLocation(location)
    .then(function(response) {
      console.log(response);
    }).catch(function(ohgod) {
      console.error(ohgod);
      setError(DEFAULT_ERROR_MESSAGE);
    })
}

function getZoningInfoForLocation(location) {
  location['spatialReference'] = SPATIAL_REFERENCE
  return fetch(GET_PARCEL_DATA_ENDPOINT + '&geometry=' + encodeURIComponent(JSON.stringify(location)))
    .then(function(response) {
      return response.json();
    }).then(function(response) {
      if (response.error) {
        throw response.error;
      }
      return response;
    });
}

function setError(message) {
  var error = document.getElementById('error-notification');
  error.textContent = message;
}