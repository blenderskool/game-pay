<template>
  <div class="justify-start">
    <h3 class="text-2xl text-center font-semibold mt-10">{{ players[activePlayerId].name }}</h3>
    
    <form class="mt-32 w-9/12" @submit.prevent="transact">
      <div class="flex">
        <MegaChoice name="type" inputValue="collect" v-model="type" overrideClass="border-green-500 text-green-500">
          Collect
        </MegaChoice>
        <MegaChoice name="type" inputValue="pay" v-model="type" overrideClass="border-red-500 text-red-500">
          Pay
        </MegaChoice>
      </div>

      <FormInput class="my-10" v-model="amount" type="number" required>
        Amount
      </FormInput>

      <div class="text-gray-700">
        <span v-if="type === 'pay'">To</span>
        <span v-else-if="type === 'collect'">From</span>
      </div>
      <div class="flex">
        <MegaChoice name="to" inputValue="0" v-model="to">
          Bank
        </MegaChoice>
        <MegaChoice
          v-for="(player, i) in opponents"
          :key="i"
          name="to"
          :inputValue="i"
          v-model="to"
        >
          {{ player.name }}
        </MegaChoice>
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
import FormInput from '@/components/FormInput.vue';
import MegaChoice from '@/components/MegaChoice.vue';

export default {
  name: 'Transact',
  components: {
    FormInput,
    MegaChoice,
  },
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