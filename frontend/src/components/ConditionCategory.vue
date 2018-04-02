<template>
    <div class="ConditionCategory">
      <a
        :href="condition.info_link"
        class="ConditionCategory__info_link"
        target="_blank"
        title="Learn more about the conditions for this use"
      >
        <font-awesome-icon
          :class="config.textClass + ' ConditionCategory__icon'"
          :icon="config.icon"
        ></font-awesome-icon>
      </a>
    </div>
</template>

<script>
  import FontAwesomeIcon from '@fortawesome/vue-fontawesome'
  import faCheckCircle from '@fortawesome/fontawesome-free-solid/faCheckCircle'
  import faQuestionCircle from '@fortawesome/fontawesome-free-solid/faQuestionCircle'
  import faTimesCircle from '@fortawesome/fontawesome-free-solid/faTimesCircle'

  /*
    key: the condition category
    icon: the FontAwesomeIcon component
    textClass: use a bootstrap text color utility to be consistent with
      other warnings and errors.
  */
  const categoryConfiguration = {
    'conditional': {
      icon: faQuestionCircle,
      textClass: 'text-info'
    },
    'not_permitted': {
      icon: faTimesCircle,
      textClass: 'text-danger'
    },
    'permitted': {
      icon: faCheckCircle,
      textClass: 'text-success'
    }
  }

  export default {
    components: {
      FontAwesomeIcon
    },
    computed: {
      config () {
        return categoryConfiguration[this.condition.category]
      }
    },
    props: ['condition']
  }
</script>

<style lang="scss" scoped>
  .ConditionCategory__icon {
    height: 2rem;
    width: 2rem;
  }
</style>
