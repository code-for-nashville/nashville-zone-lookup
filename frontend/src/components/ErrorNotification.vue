<template>
  <b-alert variant="danger" show>
    {{message}} Contact the Metro Planning Department
    at
    <a class="alert-link" href="tel:+615-862-7190">615-862-7190</a>
    or
    <a class="alert-link" href="mailto:planningstaff@nashville.gov">planningstaff@nashville.gov</a>
    for help resolving your zoning or land use question.
  </b-alert>
</template>

<script>
import bAlert from 'bootstrap-vue/es/components/alert/alert'

export default {
  components: {
    bAlert
  },
  props: ['message']
}
</script>
