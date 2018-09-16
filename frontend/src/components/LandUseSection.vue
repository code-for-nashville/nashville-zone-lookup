<template>
    <div class="pb-4 LandUse">
        <div
            @click="showCollapse = !showCollapse"
            :aria-expanded="showCollapse ? 'true' : 'false'"
            :aria-controls="'CollapseSection_' + category"
            v-if="showHeader"
        >
            <h5 class="LandUse__header CollapsibleContentHeader" :class="{ CollapsibleContentHeader__open: showCollapse }">
                {{ category }}
                <font-awesome-icon :icon="showCollapse ? upIcon : downIcon" ></font-awesome-icon>
            </h5>
        </div>
        <b-collapse v-model="showCollapse" :id="'CollapseSection_' + category">
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
        </b-collapse>
    </div>
</template>

<script>
  import ConditionCategory from './ConditionCategory.vue'
  import FontAwesomeIcon from '@fortawesome/vue-fontawesome'
  import angleUp from '@fortawesome/fontawesome-free-solid/faAngleUp'
  import angleDown from '@fortawesome/fontawesome-free-solid/faAngleDown'

  export default {
    components: {
      ConditionCategory,
      FontAwesomeIcon
    },

    data () {
      return {
        upIcon: angleUp,
        downIcon: angleDown
      }
    },

    props: [
      'category',
      'landUses',
      'showHeader',
      'showCollapse'
    ]
  }
</script>

<style lang="scss" scoped>
.LandUse__header {
    color: $primary-text-color;
    font-family: 'Merriweather', serif;
    font-weight: bold;
}

.CollapsibleContentHeader {
    padding: 1.2rem 1.5rem;
    border: 1px sold #000;
    background-color: #ddd;
    cursor: pointer;
}
.CollapsibleContentHeader__open {
    background-color: $highlight-blue;
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
