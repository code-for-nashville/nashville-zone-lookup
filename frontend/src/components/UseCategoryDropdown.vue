<template>
  <select @change="$emit('selected', $event.target.value)" class="UseCategoryDropdown">
    <option value="">Everything</option>
    <option :value="category" v-for="category in categories">
      {{ category }} Uses
    </option>
  </select>
</template>

<script>
export default {
  props: ['categories']
}
</script>

<style scoped>

.UseCategoryDropdown {
    height: 4rem;
    padding: .25rem 1.5rem;
    text-align: left;
    border: none;
    background-color: rgba(255, 255, 255, 0.19);
}

@media (min-width: 1199px) {
    .UseCategoryDropdown {
        height: 100%;
    }
}

</style>
