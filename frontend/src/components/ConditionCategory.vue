<template>
    <div class="ConditionCategory">
      <a
        :href="condition.info_link"
        class="ConditionCategory__info_link"
        target="_blank"
        title="Learn more about this condition"
      >
        <i :class="classString + ' ConditionCategory__icon'"></i>
      </a>
    </div>
</template>

<script>
  /*
    key: the condition category
    fontAwesomeIcon: the icon name, e.c "check"
    bootstrapTextType: the * portion of "text-*" - color to be consistent with
      other warnings and errors.
  */
  const categoryConfiguration = {
    'conditional': {
      fontAwesomeIcon: 'question-circle',
      bootstrapAlertType: 'info'
    },
    'not_permitted': {
      fontAwesomeIcon: 'times-circle',
      bootstrapAlertType: 'danger'
    },
    'permitted': {
      fontAwesomeIcon: 'check-circle',
      bootstrapAlertType: 'success'
    }
  }

  export default {
    computed: {
      classString () {
        const config = categoryConfiguration[this.condition.category]
        return `fa fa-${config.fontAwesomeIcon} text-${config.bootstrapAlertType}`
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
