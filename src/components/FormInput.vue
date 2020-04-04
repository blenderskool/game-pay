<template>
  <label class="text-gray-500 block my-4">
    <slot />
    <input
      v-bind="$attrs"
      class="bg-gray-800 border border-solid border-gray-700 text-gray-300 w-full p-3 rounded outline-none disabled:bg-gray-700 shadow-inner"
      :value="value"
      @input="handleInput"
    >
  </label>
</template>

<script>
export default {
  name: 'FormInput',
  props: ['value'],
  methods: {
    handleInput(e) {
      this.$emit('input', e.target.value);
    }
  }
}
</script>