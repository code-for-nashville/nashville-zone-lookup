<template>
    <div>
        <!-- Full width header -->
        <header class="ParcelHeader">
            <div class="container">
                <div class="row justify-content-between">
                    <!-- mb-0 undo the default bottom margin for h1 -->
                    <h1 class="col-12 col-md-3 py-3 mb-0">Parcel</h1>
                    <div class="col-12 mb-3 col-md-auto mb-md-0">
                        <span class="UseCategoryDropdownLabel">I'm looking for:</span>
                        <!-- Undo default bottom padding for selects -->
                        <use-category-dropdown
                            class="pb-0"
                            :onCategorySelected="onCategorySelected"
                            :categories="landUseCategories"
                            :category="category">
                        </use-category-dropdown>
                    </div>
                </div>
            </div>
        </header>
        <!-- Full width for background image -->
        <div class="AddressSearchWithBackgroundImage">
            <div class="container AddressSearch">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-6">
                        <h1>Enter your street address</h1>
                        <div class="input-group AddressSearchInput">
                            <input
                                type="text"
                                class="form-control"
                                @input="onAddressChanged($event.target.value)"
                                @keyup.enter="searchLandUse"
                                placeholder="1700 3rd Ave N, 37208"
                            >
                            <div class="input-group-append">
                                <button
                                    type="button"
                                    class="btn AddressSearchButton"
                                    @click="searchLandUse"
                                >
                                    <font-awesome-icon :icon="searchIcon"></font-awesome-icon>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12  col-md-6">
                  <error-notification v-if="errorMessage" :message="errorMessage"></error-notification>
                </div>
                <div class="w-100"></div>
                <land-use-summary
                    class="col-12 col-md-6"
                    v-if="summary" :summary="summary" :selectedCategory="category"
                    >
                </land-use-summary>
            </div>
        </div>
    </div>
</template>

<script>
  import FontAwesomeIcon from '@fortawesome/vue-fontawesome'
  import faSearch from '@fortawesome/fontawesome-free-solid/faSearch'

  import ParcelApiClient from '@/client'
  import ErrorNotification from './ErrorNotification.vue'
  import LandUseSummary from './LandUseSummary.vue'
  import UseCategoryDropdown from './UseCategoryDropdown.vue'

  export default {
    data () {
      return {
        address: '',
        category: null,
        errorMessage: null,
        landUseCategories: [],
        searchIcon: faSearch,
        summary: null
      }
    },

    methods: {
      fetchLandUseCategories () {
        ParcelApiClient
          .getLandUseCategories()
          .then(resp => resp.json())
          .then(data => {
            this.landUseCategories = data
          })
      },

      searchLandUse () {
        const address = this.address.trim()
        if (!address) {
          return
        }

        ParcelApiClient
          .getLandUseSummaryForAddress(address)
          .then(resp => Promise.all([resp, resp.json()]))
          .then(([resp, data]) => {
            if (resp.ok) {
              this.summary = data
              this.errorMessage = null
            } else {
              this.summary = null
              this.errorMessage = data.message
            }
          })
          .catch(err => {
            console.error(err)
            this.errorMessage = 'Unknown server error - please try again later.'
          })
      },

      onCategorySelected (category) {
        this.category = category
      },

      onAddressChanged (address) {
        this.address = address
      }
    },

    components: {
      ErrorNotification,
      FontAwesomeIcon,
      LandUseSummary,
      UseCategoryDropdown
    },

    created () {
      this.fetchLandUseCategories()
    }
}
</script>

<style lang="scss" scoped>
.ParcelHeader {
    background-color: $parcel-blue;
    color: $light-text-color;
}

.UseCategoryDropdownLabel {
  // Lines the label text up with the button text
  vertical-align: sub;
}

$address-search-offset: 30px;

.AddressSearchWithBackgroundImage {
    background-color: $parcel-blue;

    // The image doesn't look like much on smaller devices
    // + a little performance bonus on mobile
    @media (min-width: 576px) {
      // This image is optimized to the height of the container on medium devices
      // ~160px height on mobile, 1280px wide on desktop
      background-image: url('~/static/img/nashville-skyline-small-50-percent-transparent.png');
      background-repeat: no-repeat;
    }

    margin-bottom: $address-search-offset + 20px;

    h1, h2 {
        color: white;
    }

    .AddressSearch {
        position: relative;
        // Lines up address search text input half on background image, half off
        top: $address-search-offset;
    }

    .AddressSearchButton {
        background-color: $parcel-blue;
        color: $light-text-color;
    }
}


.AddressSearchInput {
    height: 3.5rem;
}

</style>
