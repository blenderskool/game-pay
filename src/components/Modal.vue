<template>
  <div class="modal-wrapper" @click="$emit('input', false)" v-if="value">
    <div class="bg-gray-800 modal" @click.stop>
      <slot />
    </div>
  </div>
</template>

<script>
export default {
  name: 'Modal',
  props: ['value'],
}
</script>

<style scoped>

  .modal-wrapper {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 5;
    background-color: rgba(0, 0, 0, 0.8);
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .modal {
    border-radius: 4px;
    padding: 1.25rem;
    width: 80%;
    box-shadow: 0 20px 25px -5px rgba(0,0,0,.1),0 10px 10px -5px rgba(0,0,0,.04);
  }

</style>