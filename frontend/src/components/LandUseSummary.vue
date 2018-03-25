<template>
    <div id="LandUseSummaryContainer" class="no-gutters row justify-content-center">
        <div id="LandUseSummaryContent" class="col-10 col-sm-8 col-md-6 col-lg-5 col-xl-4">
            <div id="LandUseSummaryHeader" class="col-12">
                <div class="col-10 clearfix">
                    <div class="categoryColor"></div>
                    <div class="zoningIdentifier">
                      {{ summary.zone.category }}, {{ summary.zone.code }}
                    </div>
                </div>

                <div class="col-10">
                    <p class="zoningDescription">
                        {{ summary.zone.description }}
                    </p>
                </div>
            </div>
            <div id="LandUses" class="col-12 clearfix">
                <template v-for="land_use in summary.land_uses">
                    <div class="land-use col-12">
                        {{ land_use.name }}
                    </div>
                </template>
            </div>
        </div>
    </div>
</template>

<script>
export default {
  data () {
    return {}
  },

  props: [
    'summary'
  ]
}
</script>

<style scoped>
#LandUseSummaryHeader {
  padding-top: 1rem;
  padding-bottom: 1rem;
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

.zoningIdentifier {
    float: left;
    display: inline-block;
    font-size: 20px;
    font-weight: bold;
    margin-top: 0.5rem;
}

.zoningDescription {
  text-align: left;
}

</style>
