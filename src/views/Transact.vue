<template>
  <div class="justify-start">
    <h3 class="text-2xl text-center font-semibold mt-10">{{ players[activePlayerId].name }}</h3>
    
    <form class="mt-32 w-9/12" @submit.prevent="transact">

      <div class="flex">
        <label
          class="bg-white block text-center rounded text-green-500 mr-2 w-full py-5 shadow border-solid border-green-500 text-lg"
          :class="{'border-2': type === 'collect'}"
        >
          Collect
          <input
            v-model="type"
            class="hidden"
            type="radio"
            name="type"
            value="collect"
          >
        </label>
        <label
          class="bg-white block text-center rounded text-red-500 ml-2 w-full py-5 shadow border-solid border-red-500 text-lg"
          :class="{'border-2': type === 'pay'}"
        >
          Pay
          <input
            v-model="type"
            class="hidden"
            type="radio"
            name="type"
            value="pay"
          >
        </label>
      </div>

      <label class="text-gray-700 block my-10">
        Amount
        <input v-model="amount" type="number" required>
      </label>

      <div class="text-gray-700">
        <span v-if="type === 'pay'">To</span>
        <span v-else-if="type === 'collect'">From</span>
      </div>
      <div class="flex">
        <label
          class="bg-white block text-center rounded text-blue-500 mr-2 w-full py-5 shadow border-solid border-blue-500 text-lg"
          :class="{'border-2': to === '0'}"
        >
          Bank
          <input
            v-model="to"
            class="hidden"
            type="radio"
            name="to"
            value="0"
          >
        </label>
        <label
          class="bg-white block text-center rounded text-blue-500 ml-2 w-full py-5 shadow border-solid border-blue-500 text-lg"
          :class="{'border-2': to === i}"
          :key="i"
          v-for="(player, i) in opponents"
        >
          {{ player.name }}
          <input
            v-model="to"
            class="hidden"
            type="radio"
            name="to"
            :value="i"
          >
        </label>
      </div>

      <button
        type="submit"
        class="fixed w-4/6 text-white transform -translate-x-1/2"
        style="bottom: 30px; left: 50%"
        :class="type === 'pay' ? 'bg-red-500' : 'bg-green-500'"
      >
        <span v-if="type === 'pay'">
          Pay
        </span>
        <span v-if="type === 'collect'">
          Collect
        </span>
      </button>
    </form>
  </div>
</template>

<script>
export default {
  name: 'Transact',
  data() {
    return {
      type: 'pay',
      to: '0',
      amount: 0,
    }
  },
  computed: {
    activePlayerId() {
      return this.$route.params.id;
    },
    players() {
      return JSON.parse(localStorage.getItem('game'));
    },
    opponents() {
      const { [this.activePlayerId]: _, ...opponents } = this.players;
      return opponents;
    }
  },
  methods: {
    transact() {
      let amount = parseInt(this.amount);
      const players = { ...this.players };
      const activePlayer = players[this.activePlayerId];
      const type = this.type;


      if (type === 'pay') {
        amount = -amount;
      }

      activePlayer.amount += amount;
      activePlayer.transactions.push({
        type,
        amount,
      });

      if (this.to !== '0') {
        players[this.to].amount -= amount;
        players[this.to].transactions.push({
          type: type === 'pay' ? 'collect' : 'pay',
          amount,
        });
      }

      localStorage.setItem('game', JSON.stringify(players));

      this.$router.replace('/game');
    }
  }
}
</script>