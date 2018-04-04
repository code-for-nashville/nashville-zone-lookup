<template>
<b-dropdown :text="category" class="UseCategoryDropdown" right>
  <b-dropdown-item-button class="category-item" @click="onCategorySelected('Everything')">Everything</b-dropdown-item-button>
  <b-dropdown-item-button class="category-item" :value="category" v-for="category in categories" @click="onCategorySelected(category)">
    {{ category }} Uses
  </b-dropdown-item-button>
  </b-dropdown>
</template>

<script>
import bDropdown from 'bootstrap-vue/es/components/dropdown/dropdown'
import bDropdownItemButton from 'bootstrap-vue/es/components/dropdown/dropdown-item-button'
export default {
  name: 'category-dropdown',
  props: ['categories', 'onCategorySelected', 'category'],
  components: {bDropdown, bDropdownItemButton}
}
</script>

<style lang="scss" scoped>
.UseCategoryDropdown {
  border: none;
  color: $light-text-color;
  font-weight: 500;
  height: 4rem;
  min-width: 18rex;

  .category-item {
    color: #fff;
    font-weight: 500;
    min-width: 18rex;
    text-align: left;
  }
  .category-item:focus {
    outline:0;
    background-color: $secondary-blue;
  }
}

@media (min-width: 1199px) {
  .UseCategoryDropdown {
    height: 100%;
  }
}
</style>
