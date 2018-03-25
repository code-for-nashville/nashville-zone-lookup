<template>
  <div>
    <div class="no-gutters row">
      <div class="headerContainer d-flex align-items-start primaryBackgroundColor primaryTextColor mx-auto col-12">
        <div class="headerImageContainer primaryBackgroundColor">
          <img src="../assets/nashville-skyline.png">
        </div>

        <button class="btn btn-secondary textHeader ml-auto col-3" type="button">Parcel</button>

        <div class="ml-auto col-8">

          <use-category-dropdown
            @selectedUse="onUseCategorySelected"
            :uses="landUseCategories">
          </use-category-dropdown>

        </div>
      </div>
    </div>

    <div id="addressContentContainer" class="no-gutters row justify-content-center">
      <div class="col-10 col-sm-8 col-md-6 col-lg-5 col-xl-4">
        <h2>Enter street address<br> or zoning code</h2>
      </div>

      <div class="w-100"></div>

      <div id="addressInputContainer" class="col-10 col-sm-8 col-md-6 col-lg-5 col-xl-4">

        <input
          type="text"
          name=""
          id="addressInput"
          @input="onAddressChanged($event.target.value)"
          placeholder="1700 3rd Ave N, 37208 or 1238817">

      </div>
    </div>

    <land-use-summary v-if="summary" :summary="summary"></land-use-summary>

  </div>
</template>

<script>
  import { debounce } from 'lodash'
  import { mapGetters, mapActions, mapState } from 'vuex'
  import LandUseSummary from './LandUseSummary.vue'
  import UseCategoryDropdown from './UseCategoryDropdown.vue'

  export default {
    data () {
      return {}
    },

    computed: {
      ...mapState('parcel', { summary: state => state.landUseSummary }),

      ...mapGetters({
        landUseCategories: 'parcel/landUseCategories'
      })
    },

    methods: {
      ...mapActions({
        fetchLandUseCategories: 'parcel/fetchLandUseCategories',
        fetchLandUseSummaryForAddress: 'parcel/fetchLandUseSummaryForAddress'
      }),

      onUseCategorySelected (use) {
        console.info(use)
        // TODO filter search summary land uses down to use category of interest
      },

      onAddressChanged: debounce(function (address) {
        return this.fetchLandUseSummaryForAddress(address)
      }, 450)
    },

    components: {
      LandUseSummary,
      UseCategoryDropdown
    },

    created () {
      this.fetchLandUseCategories()
    }
}
</script>

<style scoped>
.primaryBackgroundColor {
  background-color: #1B355D;
}

.primaryTextColor {
  color: #FFF;
}

.secondaryTextColor {
  color: #4A4A4A;
}

.headerContainer {
  height: 10vh;
  min-height: 4rem;
}

.headerImageContainer {
  position: fixed;
  margin-top: 3.8rem;
}

.headerImageContainer {
  margin-top: 3.8rem;
  z-index: -1;
}

.headerContainer img {
    height: 6rem;
    margin-bottom: -0.5rem;
  opacity: 0.5;
  z-index: -1;
}

.textHeader {
    text-align: left;
    font-size: x-large;
    height: 10vh;
    min-height: 4rem;
    max-width: 6.2rem;
    background-color: rgba(255, 255, 255, 0);
    border: none;
}

.btn-secondary.focus, .btn-secondary:focus {
  box-shadow: none;
}


#addressContentContainer {

}

h2 {
  margin-top: 0.5rem;
    text-align: left;
    font-size: 25px;
    color: #FFF;
}

#addressInputContainer {
  margin-top: 0.5rem;
}

#addressInput {
    height: 3.5rem;
    width: 100%;
    padding: 3px 10px;
    border: 1px solid #ccc;
    border-radius: 0.3rem;
    box-shadow: 0px 0px 1px 0.25px rgba(204,204,204,1);
}
@media (min-width: 575px) {
  .headerContainer img {
    height: initial;
  }
}

@media (min-width: 767px) {
  .textHeader {
      font-size: 3vw;
  }

  #addressContentContainer {
      margin-top: 4%;
  }
}

@media (min-width: 992px) {
  #addressContentContainer {
      margin-top: 5%;
  }

  h2 {
    font-size: 30px;
  }
}

@media (min-width: 1199px) {
  .headerContainer {
      height: 5rem;
      max-width: 1440px;
  }

  .subheaderContainer {
      max-width: 1440px;
  }

  .textHeader {
      height: 5rem;
      text-align: left;
      font-size: 2.2rem;
  }

  #addressContentContainer {
      margin-top: 4.5%;
  }

  h2 {
    font-size: 35px;
  }
}

@media (min-width: 1440px) {
  .textHeader {
      padding-left: 2.5rem;
  }

  #addressContentContainer {
      margin-top: 5rem;
  }
}
</style>
