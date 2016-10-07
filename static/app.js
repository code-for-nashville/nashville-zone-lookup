(function (ctx, _) {
    'use strict'
        //
    // Set a minimum length before we start pinging the address service
    // to avoid spamming it.
    const ADDRESS_RESULT_CLASS = 'address-result',
          DEFAULT_ERROR_MESSAGE = 'We\'re having trouble getting addresses right now. If you believe this is a serious issue, please email <support@somesite.com>',
          ZONING_ERROR_MESSAGE = 'We\'re having a bit of difficulty looking up your zoning issue. Try again in a few minutes.',
          MINIMUM_ADDRESS_SEARCH_LENGTH = 4,
          MAX_LOCATIONS_DISPLAYED = 5,
          SPATIAL_REFERENCE = JSON.stringify({"wkid":102100,"latestWkid":3857}),
          // the outSR parameter defines the version of the spatial reference returned
          FIND_ADDRESS_ENDPOINT = 'http://maps.nashville.gov/arcgis/rest/services/Locators/LocNashComp/GeocodeServer/findAddressCandidates?outSR=' +
            encodeURIComponent(SPATIAL_REFERENCE) + '&maxLocations=' + MAX_LOCATIONS_DISPLAYED + '&f=json',
          GET_PARCEL_DATA_ENDPOINT = 'http://maps.nashville.gov/arcgis/rest/services/Cadastral/Cadastral_Layers/MapServer/4/query?' +
            'f=json&returnGeometry=true&spatialRel=esriSpatialRelIntersects&geometryType=esriGeometryPoint&inSR=102100&outFields=*&outSR=102100';

    const GET_ZONING_HIST_ENDPOINT = "/api/zoningHistory";

    var app = new Vue({
        el: "#app",
        data: {
            title: "MetroSetbacks",
            addressQuery: "",
            addressResults: [],
            zoningInfo: {},
            querying: false,
            dropDownOpen: false,
            errorMessage: "",

            showSearchSpinner: false,
            showIntro: true,
            showError: false,
            showZoningInfo: false
        },

        methods: {
            reset: function reset () {
                this.showSearchSpinner = false;
                this.showIntro = true;
                this.showError = false;
                this.showZoningInfo = false
            },

            _showError: function _showError () {
                this.showSearchSpinner = false;
                this.showIntro = false;
                this.showError = true;
                this.showZoningInfo = false
            },

            _showZoningInfo: function _showZoningInfo () {
                this.showSearchSpinner = false;
                this.showIntro = false;
                this.showError = false;
                this.showZoningInfo = true
            },

            onErr: function onErr (err) {
                console.error(err);
                this.errorMessage = err && err.message || "An error has occured";
                this._showError()
            },

            getZoningInfo: function getZoningInfo (address) {
                address['spatialReference'] = SPATIAL_REFERENCE

                var url = GET_PARCEL_DATA_ENDPOINT + "&geometry="
                    + encodeURIComponent(JSON.stringify(address));

                var self = this;

                fetch(url)
                    .then(function (resp) {
                        return resp.json()
                        //return res;
                    })
                    .then(function (parcel) {
                        if (parcel.error) throw parcel.error;

                        if (parcel.features.length > 0)
                            var parcelId = parcel.features[0].attributes.ParID;
                        else throw new Error("We can't find good info on that addess. Please contact <email address>");

                        var url = GET_ZONING_HIST_ENDPOINT + "?pin=" + parcelId;

                        return fetch(url);
                    })
                    .then(function (resp) {
                        return resp.json();
                    })
                    .then(function (zoningInfo) {
                        self.zoningInfo = zoningInfo;
                        //self.addressResults = [];

                        self._showZoningInfo()
                    })
                    .catch(self.onErr);
            },

            doSearch: _.debounce(function doSearch () {
                var query = this.addressQuery;

                if (query.length < 5) {
                    this.addressResults = [];
                    this.showZoningInfo = false;
                    this.showIntro = true;
                    return;
                }

                var url = FIND_ADDRESS_ENDPOINT + '&SingleLine='
                    + encodeURIComponent(query)

                var self = this;

                this.showSearchSpinner = true;

                fetch(url)
                    .then(function(response) {
                        return response.json();
                    })
                    .then(function (hits) {
                        self.showSearchSpinner = false;

                        self.addressResults = hits.candidates.map(function (hit) {
                            return {
                                x: hit.location.x,
                                y: hit.location.y,
                                address: hit.address
                            }
                        });
                    })
                    .catch(self.onErr);
            }, 400)
        }
    })
})(window, _)
