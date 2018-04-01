<template>
    <div class="LandUseSummary">
        <div class="row LandUseSummaryHeader">
            <div class="col-12">
                <span class="CategoryColor"></span>
                <span class="ZoningIdentifier">
                    {{ summary.zone.category }}, {{ summary.zone.code }}
                </span>
            </div>

            <div class="col-12">
                <p class="ZoningDescription">
                    {{ summary.zone.description }}
                </p>
            </div>
        </div>
        <land-use-section
            :category="selectedCategory"
            :landUses="landUsesByCategory[selectedCategory]"
            :showHeader="false"
            class="SelectedLandUseCategory"
            v-if="selectedCategory"
        >
        </land-use-section>
        <land-use-section
            :category="category"
            :key="category"
            :landUses="landUses"
            :showHeader="true"
            class="OtherLandUseCategories"
            v-for="(landUses, category) in landUsesByCategory"
            v-if="!selectedCategory || (displayOtherUses && category != selectedCategory)"
        >
        </land-use-section>
        <div class="row justify-content-center">
            <div class="col-auto">
                <button
                    class="btn btn-link"
                    @click="enableDisplayOtherUses()"
                    v-if="showOtherUsesExpander"
                >
                    View Other Uses <i class="fa fa-caret-down"></i>
                </button>
            </div>
        </div>
    </div>
</template>

<script>
import { groupBy } from 'lodash'
import LandUseSection from './LandUseSection.vue'

export default {
  components: {
    LandUseSection
  },
  computed: {
    landUsesByCategory () {
      return groupBy(this.summary.land_uses, l => l.category)
    },
    // Whether we should display the "View Other Uses" button
    showOtherUsesExpander () {
      return (
        // There is a selected category
        this.selectedCategory &&
        // We're not already showing them
        !this.displayOtherUses
      )
    }
  },
  data () {
    return {
      displayOtherUses: false
    }
  },
  methods: {
    enableDisplayOtherUses () {
      this.displayOtherUses = true
    }
  },
  props: [
    'selectedCategory',
    'summary'
  ]
}
</script>

<style scoped>
.LandUseSummaryHeader {
    padding-bottom: 1rem;
}

.CategoryColor {
    background-color: blue;
    border-radius: 50%;
    display: inline-block;
    float: left;
    height: 18px;
    margin-right: 0.5rem;
    margin-top: 0.85rem;
    width: 18px;
}

.ZoningIdentifier {
    display: inline-block;
    float: left;
    font-size: 20px;
    font-weight: bold;
    margin-top: 0.5rem;
}

.ZoningDescription {
    text-align: left;
}
</style>
