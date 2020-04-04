<template>
  <button
    class="text-lg focus:outline-none font-medium py-3 px-4 rounded disabled:opacity-50"
    :class="{
      // 'bg-green-400': this.variant === 'primary' && this.success,
      // 'bg-red-400': this.variant === 'primary' && this.danger,
      // 'bg-blue-400': this.variant === 'primary' && !this.success && !this.danger,
      'shadow-lg text-gray-900': this.variant === 'primary',

      // 'border-green-400 text-green-400': this.variant === 'secondary' && this.success,
      // 'border-red-400 text-red-400': this.variant === 'secondary' && this.danger,
      // 'border-blue-400 text-blue-400': this.variant === 'secondary' && !this.success && !this.danger,
      'bg-transparent border-2 border-solid': this.variant === 'secondary',
    }"
    v-bind="$attrs"
    v-on="$listeners"
  >
    <slot />
  </button>
</template>

<script>
export default {
  name: 'Button',
  props: {
    variant: {
      type: String,
      default: 'primary',
    },
  },
}
</script>