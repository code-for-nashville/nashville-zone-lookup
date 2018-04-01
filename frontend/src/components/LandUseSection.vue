<template>
    <div class="pb-4 LandUse">
        <h5 class="LandUse__header" v-if="showHeader">{{ category }}</h5>
        <div v-for="landUse in landUses" class="card mb-2">
            <div class="card-body LandUse__use">
                <h6 class="card-title">
                    {{ landUse.name }}
                </h6>
                <p class="card-text">
                    {{ landUse.condition.description }}
                </p>
            </div>
        </div>
    </div>
</template>

<script type="text/javascript">
    export default {
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
</style>
