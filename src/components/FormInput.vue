<template>
  <label class="text-gray-700 block my-4">
    <slot />
    <input v-bind="$attrs" :value="value" @input="handleInput">
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