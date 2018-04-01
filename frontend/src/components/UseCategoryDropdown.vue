<template>
  <select @change="$emit('selected', $event.target.value)" class="useCategoryDropdown">
    <option value="">Everything</option>
    <option v-for="category in categories">
      {{ category }}
    </option>
  </select>
</template>

<script>
export default {
  props: ['categories']
}
</script>

<style scoped>

.useCategoryDropdown {
    min-width: 18rem;
    width: 24rem;
    height: 10vh;
    min-height: 4rem;
    margin-right: 0rem;
    padding: .25rem 1.5rem;
    text-align: left;
    border: none;
    border-radius: initial;
    background-color: rgba(255, 255, 255, 0.19);
}

@media (min-width: 1199px) {
    .useCategoryDropdown {
        height: 100%;
    }
}

</style>
