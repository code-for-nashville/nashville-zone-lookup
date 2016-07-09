(function (ctx, $) {
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

    //let GET_ZONING_HIST_ENDPOINT = 'http://maps.nashville.gov/ParcelService/Search.asmx/GetZoningHistory?onlyactive=false';
    const GET_ZONING_HIST_ENDPOINT = "/api/zoningHistory";

    var addressInput = document.getElementById('address-input'),
        addressResults = document.getElementsByClassName('address-results')[0],
        introduction = document.getElementById('introduction'),
        template = document.getElementById('address-result-template');

    addressInput.addEventListener('keyup', debounce(populateAddressSearchResults, false, 400));

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

          var parId = response.features[0].attributes.ParID;

          getZoningHist(parId, function (err, txt) {
              if (err) return setError(ZONING_ERROR_MESSAGE);

              let zone = JSON.parse(txt);
              console.log(zone);
          });

        //}).then(function (response) {
            //console.info(response);
            //return response.text();

        //}).then(function (body) {
            //console.info("in text then")
            //console.log(body);

        }).catch(function(ohgod) {
          console.error(ohgod);
          setError(DEFAULT_ERROR_MESSAGE);
        })
    }

    function getZoningInfoForLocation(location) {
      location['spatialReference'] = SPATIAL_REFERENCE

      //var url = new URLSearchParams()
      //url.set("geometry", JSON.stringify(location))
      //var queryString = url.toString();

      //return fetch("/api/zoningHistory?" + queryString)
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

    /**
     *
     * Bind as a callback to an event or whatever. Function will exhibit one of two
     * behaviors:
     *
     * imm === true, the debounced callback (`fn`) will be fired immediately on the
     * bound event, and then at least `wait` ms must pass before it will be allowed
     * to fire again.
     *
     * imm === false, the debouncer will start a countdown of `wait` ms when the
     * bound event is first fired. The debounced callback will fire after the
     * countdown ellapses.  Every time a successive instance of the bound event
     * fires, the countdown will reset, and the debounced callback will only fire
     * after the countdown is allowed to run out.
     *
     * @param {function} fn Callback to be debounced
     * @param {boolean} imm Immediate flag, see above description
     * @param {number} wait Millisecond wait time
     */
    function debounce (fn, imm, wait) {
      var to, wait = wait || 300;

      return function debounced () {
        var self = this, args = arguments;

        var later = function later () {
          to = null;
          if (!imm) fn.apply(self, args);
        }

        var callNow = imm && !to;
        clearTimeout(to);
        to = setTimeout(later, wait);
        if (callNow) fn.apply(self, args);
      }
    }
})(window, jQuery)
