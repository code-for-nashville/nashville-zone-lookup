<template>
  <div>
    <div class="no-gutters row">
      <div class="headerContainer d-flex align-items-start primaryBackgroundColor primaryTextColor mx-auto col-12">
        <div class="headerImageContainer primaryBackgroundColor">
          <img src="../assets/nashville-skyline.png">
        </div>
        <button class="btn btn-secondary textHeader ml-auto col-3" type="button">Parcel</button>
        <div class="ml-auto col-8">
          <div class="headerDropdownContainer dropdown primaryTextColor">
            <button class="headerDropdown btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Everything
              <i class="primaryTextColor fa fa-caret-down float-right" aria-hidden="false"></i>
            </button>
            <div class="dropdown-menu scrollable-menu" aria-labelledby="dropdownMenuButton">
              <li v-for="intendedUse in intendedUses">
                <a class="dropdown-item" href="#">{{ intendedUse.name }}</a>
              </li>
              <div class="dropdown-divider"></div>
              <li>
                <a class="gotom" href="#">
                  <i class="fa fa-cloud-download" aria-hidden="false"></i>Download PDF
                </a>
              </li>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div id="addressContentContainer" class="no-gutters row justify-content-center">
      <div class="col-10 col-sm-8 col-md-6 col-lg-5 col-xl-4">
        <h2>Enter street address<br> or zoning code</h2>
      </div>
      <div class="w-100"></div>
      <div id="addressInputContainer" class="col-10 col-sm-8 col-md-6 col-lg-5 col-xl-4">
        <input type="text" name="" id="addressInput" placeholder="1700 3rd Ave N, 37208 or 1238817">
      </div>
    </div>
    <div id="searchResultsContainer" class="no-gutters row justify-content-center">
      <div id="searchResultsHeader" class="col-10 col-sm-8 col-md-6 col-lg-5 col-xl-4">
        <div class="col-10 clearfix">
          <div class="categoryColor"></div>
          <div class="zoningCategory">Industrial, IDW</div>
        </div>
        <div class="col-10">
          <p class="zoningDescription">
            Industrial Warehousing/Distribution, intended for a wide range of warehousing, wholesaling, and bulk distribution uses.
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'

  export default {
    computed: {
      ...mapGetters({
        intendedUses: 'intendedUses/intendedUses'
      })
    },
    methods: {
      ...mapActions({
        fetchAllIntendedUses: 'intendedUses/fetchAllIntendedUses'
      })
    },
    created () {
      this.fetchAllIntendedUses()
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

.headerDropdownContainer {
  float: right;
}

.headerDropdown {
  min-width: 164px;
  height: 10vh;
  min-height: 4rem;
    margin-right: 0rem;
    padding: .25rem 1.5rem;
    text-align: left;
    border: none;
    border-radius: initial;
  background-color: rgba(255, 255, 255, 0.19);
}

  .headerDropdown ~ .dropdown-menu {
    background-color: #435572;
    color: #5C6C84;
  }

  .headerDropdown ~ .dropdown-menu a {
    padding: 3vh 1.5rem;
    font-size: 1rem;
    color: #FFF;
  }

    .headerDropdown ~ .dropdown-menu a:hover {
      background-color: #2F4263;
    }

  .headerDropdown ~ .show {
    top: -2px;
    left: 0px;
    width: 164px;
    margin: 0;
    padding-top: 0;
    border-radius: 0;
    border: none;
  }

  .headerDropdown ~ .fa-caret-down {
    text-align: right;
  }

.scrollable-menu {
    height: auto;
    max-height: 300px;
    overflow-x: hidden;
}

.dropdown-toggle::after {
  border: none;
}

.show >.headerDropdown.dropdown-toggle {
  background-color: #435572;
}

.fa-cloud-download {
  margin-right: 0.5rem;
  color: #FFF;
}

#addressContentContainer {

}

.categoryColor {
    float: left;
    display: inline-block;
    height: 18px;
    width: 18px;
    margin-top: 0.85rem;
    margin-right: 0.5rem;
    border-radius: 50%;
    background-color: blue;
}

.zoningCategory {
    float: left;
    display: inline-block;
    font-size: 20px;
    font-weight: bold;
    margin-top: 0.5rem;
}

.zoningDescription {
  text-align: left;
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

#searchResultsHeader {
  height: 5rem;
}

@media (min-width: 575px) {
  .headerDropdown {
    min-width: 18rem;
  }

  .headerContainer img {
    height: initial;
  }

  .headerDropdown ~ .show {
    top: -2px;
    left: 0px;
    min-width: 18rem;
    margin: 0;
    border-radius: 0;
    border: none;
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

  .headerDropdown {
      width: 24rem;
    height: 5rem;
  }

  .headerDropdown ~ .show {
    min-width: 24rem;
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

  .headerDropdown {
      margin-right: 7rem;
  }

  #addressContentContainer {
      margin-top: 5rem;
  }
}
</style>
