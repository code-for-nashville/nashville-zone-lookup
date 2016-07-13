(function (ctx, _) {
    'use strict'

    // Set a minimum length before we start pinging the address service
    // to avoid spamming it.
    const ADDRESS_RESULT_CLASS = 'address-result',
          DEFAULT_ERROR_MESSAGE = 'We\'re having trouble getting addresses right now. If you believe this is a serious issue, please email shenfieldmax@gmail.com',
          ZONING_ERROR_MESSAGE = 'We\'re having a bit of difficulty looking up your zoning issue. Try again in a few minutes.',
          MINIMUM_ADDRESS_SEARCH_LENGTH = 4,
          MAX_LOCATIONS_DISPLAYED = 5,
          SPATIAL_REFERENCE = JSON.stringify({"wkid":102100,"latestWkid":3857}),
          FIND_ADDRESS_ENDPOINT = 'http://maps.nashville.gov/arcgis/rest/services/Locators/LocNashComp/GeocodeServer/findAddressCandidates?outSR=' +
            encodeURIComponent(SPATIAL_REFERENCE) + '&maxLocations=' + MAX_LOCATIONS_DISPLAYED + '&f=json',
          GET_PARCEL_DATA_ENDPOINT = 'http://maps.nashville.gov/arcgis/rest/services/Cadastral/Cadastral_Layers/MapServer/4/query?' +
            'f=json&returnGeometry=true&spatialRel=esriSpatialRelIntersects&geometryType=esriGeometryPoint&inSR=102100&outFields=*&outSR=102100';

    const GET_ZONING_HIST_ENDPOINT = "/api/zoningHistory";

    var addressInput = document.getElementById('address-input'),
        addressResults = document.getElementsByClassName('address-results')[0],
        introduction = document.getElementById('introduction'),
        template = document.getElementById('address-result-template');

    addressInput.addEventListener('keyup', _.debounce(populateAddressSearchResults, 400));

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

    const zoneTemp = document.getElementById("zone-info-template").innerText;

    const zoneDispFun = _.template(zoneTemp);

    function openLocationPage(e) {
      var location = {
        x: +e.target.dataset.x,
        y: +e.target.dataset.y
      };

      hideIntroduction();

      getZoningInfoForLocation(location)
        .then(function(response) {
          console.log(response);

          var parId = response.features[0].attributes.ParID;

          getZoningHist(parId, function (err, txt) {
              if (err) {
                setError(ZONING_ERROR_MESSAGE);
                return;
              }

              var zoneInfo  = JSON.parse(txt);

              var tempDisplay = document.getElementById('temp-zone-display');

              tempDisplay.innerHTML
                  = zoneDispFun(zoneInfo);

              return zoneInfo;
          });
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

    function getZoningHist(parId, cb) {
        let url = GET_ZONING_HIST_ENDPOINT + "?pin=" + parId;

        let xhr = genXHR(url);

        xhr.onload = function onLoad () {
            var zoneHistory = xhr.responseBody|| xhr.responseText;
            cb(null, zoneHistory);
        }

        xhr.onerror = function onError (err) {
            cb(err);
        }

        xhr.send();
    }

    function setError(message) {
      var error = document.getElementById('error-notification');
      error.textContent = message;
    }

    function genXHR (method, url) {
        if (!url) {
            url = method;
            method = "GET";
        }

        let xhr = new XMLHttpRequest();

        xhr.open(method, url, true);

        return xhr;
    }
})(window, _)
