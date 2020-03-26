<template>
  <label :class="`bg-white block text-center rounded mr-2 w-full py-5 shadow border-solid text-lg cursor-pointer ${style} ${value === inputValue && activeStyle}`">
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
  computed: {
    activeStyle() {
      if (!this.activeClass) return 'border-2';

      return this.activeClass;
    },
    style() {
      if (!this.overrideClass) return 'text-blue-500 border-blue-500';

      return this.overrideClass;
    }
  },
  methods: {
    handleInput(e) {
      this.$emit('input', e.target.value);
    }
  }
}
</script>