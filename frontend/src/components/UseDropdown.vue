<template>
  <div class="headerDropdownContainer dropdown primaryTextColor">
    <button class="headerDropdown btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      Everything
      <i class="primaryTextColor fa fa-caret-down float-right" aria-hidden="false"></i>
    </button>

    <div class="dropdown-menu scrollable-menu" aria-labelledby="dropdownMenuButton">
      <li v-for="use in uses">

        <a class="dropdown-item"
          href="#"
          @click="$emit('selectedUse', use)"
        > {{ use }} </a>

      </li>

      <div class="dropdown-divider"></div>

      <li>
        <a class="gotom" href="#">
          <i class="fa fa-cloud-download" aria-hidden="false"></i>Download PDF
        </a>
      </li>

    </div>
  </div>
</template>


<script>
export default {
  props: ['uses']
}

</script>

<style>
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

@media (min-width: 575px) {
  .headerDropdown {
    min-width: 18rem;
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

@media (min-width: 1199px) {
  .headerDropdown {
      width: 24rem;
    height: 5rem;
  }

  .headerDropdown ~ .show {
    min-width: 24rem;
  }
}

@media (min-width: 1440px) {
  .headerDropdown {
      margin-right: 7rem;
  }

}
</style>
