<template>
    <div class="LandUseSummary">
        <div class="LandUseSummaryHeader row">
            <div class="col-12">
                <span class="categoryColor"></span>
                <span class="zoningIdentifier">
                    {{ summary.zone.category }}, {{ summary.zone.code }}
                </span>
            </div>

            <div class="col-12">
                <p class="zoningDescription">
                    {{ summary.zone.description }}
                </p>
            </div>
        </div>
        <template v-for="land_use in land_uses">
            <div class="LandUse card mb-2">
                <div class="card-body">
                    <h5 class="card-title">
                        {{ land_use.name }}
                    </h5>
                    <p class="card-text">
                        {{ land_use.condition.description }}
                    </p>
                </div>
            </div>
        </template>
    </div>
</template>

<script>
export default {
  computed: {
    land_uses: function () {
      if (!this.category) {
        return this.summary.land_uses
      }
      return this.summary.land_uses.filter(l => l.category === this.category)
    }
  },
  props: [
    'category',
    'summary'
  ]
}
</script>

<style scoped>
#LandUseSummaryHeader {
    padding-bottom: 1rem;
    padding-top: 1rem;
}

.LandUse h5.card-title{
    font-family: 'Source Sans Pro', serif
}

.categoryColor {
    background-color: blue;
    border-radius: 50%;
    display: inline-block;
    float: left;
    height: 18px;
    margin-right: 0.5rem;
    margin-top: 0.85rem;
    width: 18px;
}

.zoningIdentifier {
    display: inline-block;
    float: left;
    font-size: 20px;
    font-weight: bold;
    margin-top: 0.5rem;
}

.zoningDescription {
    text-align: left;
}
</style>
