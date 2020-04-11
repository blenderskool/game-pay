<template>
  <div class="justify-center">

    <div class="w-9/12 text-center py-20 mb-5 -mt-24 border-2 border-dotted border-blue-400 rounded-md text-blue-400">
      <NFCReader v-model="playerId" />
      Bring player card here to<br>
      start a transaction
    </div>

    <ul class="w-9/12 grid grid-cols-2 gap-3">
      <li
        :key="i"
        v-for="(player, i) in players"
        class="bg-gray-800 text-gray-100 p-4 rounded text-center shadow-md"
      >
        <div class="w-8 h-8 rounded-full bg-blue-500 inline-block" />
        <h2 class="mt-3 font-medium text-2xl">
          {{ player.name }}
        </h2>
        <h3 class="text-green-500 font-semibold">
          {{ new Intl.NumberFormat('en-IN').format(player.amount) }}
        </h3>
      </li>
    </ul>

    <Button class="border-red-800 text-red-800 fixed w-4/6" style="bottom: 30px" @click="endGame" variant="secondary" danger>
      End Game
    </Button>

  </div>
</template>

<script>
import NFCReader from '@/components/NFCReader.vue';
import Button from '@/components/Button.vue';

export default {
  name: 'Game',
  components: {
    NFCReader,
    Button,
  },
  data() {
    return {
      playerId: '',
    }
  },
  computed: {
    players() {
      return JSON.parse(localStorage.getItem('game'));
    }
  },
  watch: {
    playerId() {
      this.$router.push(`/transact/${this.playerId}`);
    }
  },
  methods: {
    endGame() {
      localStorage.removeItem('game');
      this.$router.replace('/');
    }
  }
}
</script>