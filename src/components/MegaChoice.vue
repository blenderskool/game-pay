<template>
  <label
    :class="
      `bg-gray-800 block text-center rounded mr-2 w-full py-5 shadow-lg border-solid text-lg cursor-pointer
      ${this.overrideClass || 'text-blue-400 border-blue-400'}
      ${value === inputValue && (this.activeClass || 'border-2 shadow-inner')}`
    "
  >
    <slot />
    <input @input="handleInput" class="hidden" type="radio" :name="name" :value="inputValue">
  </label>
</template>

<script>
export default {
  name: 'MegaChoice',
  props: {
    name: {
      type: String,
      required: true,
    },
    value: String,
    inputValue: {
      type: String,
      required: true,
    },
    activeClass: String,
    overrideClass: String,
  },
  methods: {
    handleInput(e) {
      this.$emit('input', e.target.value);
    }
  }
}
</script>