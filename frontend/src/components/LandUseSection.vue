<template>
    <div class="pb-4 LandUse">
        <h5 class="LandUse__header" v-if="showHeader">{{ category }}</h5>
        <div v-for="landUse in landUses" class="card mb-2">
            <div class="card-body row align-items-center justify-content-between LandUse__use">
                <div class="col-10">
                    <h6 class="card-title">
                        {{ landUse.name }}
                    </h6>
                    <p class="card-text">
                        {{ landUse.condition.description }}
                    </p>
                </div>
                <div class="col-2">
                    <condition-category :condition="landUse.condition"></condition-category>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
  import ConditionCategory from './ConditionCategory.vue'

  export default {
    components: {
      ConditionCategory
    },

    props: [
      'category',
      'landUses',
      'showHeader'
    ]
  }
</script>

<style lang="scss" scoped>
.LandUse__header {
    color: $primary-text-color;
    font-family: 'Merriweather', serif;
    font-weight: bold;
}

.LandUse__use .card-title {
    color: $secondary-text-color;
    font-family: 'Source Sans Pro', serif;
    font-weight: bold;
}

.LandUse__condition_category {
    // #891E26 red
    color: #257419;
    height: 2rem;
    width: 2rem;
}
</style>
