<template>
    <div id="searchResultsContainer" class="no-gutters row justify-content-center">
      <div id="searchResultsHeader" class="col-10 col-sm-8 col-md-6 col-lg-5 col-xl-4">
          <template v-for="result in results">
            <div class="col-10 clearfix">
              <div class="categoryColor"></div>
              <div class="zoningCategory">{{ result.zoning_category }}</div>
            </div>

            <div class="col-10">
              <p class="zoningDescription">
                {{ result.zoning_description }}
              </p>
            </div>
        </template>
      </div>
    </div>
</template>

<script>
export default {
  data () {
    return {}
  },

  created () {
    console.info('i live')
  },

  props: [
    'results'
  ]
}
</script>

<style scoped>
#searchResultsHeader {
  height: 5rem;
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

</style>

