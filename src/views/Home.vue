<template>
  <div class="justify-center">
    
    <div class="bg-gray-800 text-gray-100 p-5 rounded shadow-xl w-9/12">
      <ul class="p-0 mb-6 list-none" v-if="Object.keys(players).length">
        <li :key="id" v-for="(player, id) in players" class="p-2 flex">
          <h2 class="m-0 font-medium text-xl">{{ player.name }}</h2>
          <h3 class="ml-auto font-semibold text-base text-green-500">
            +{{ new Intl.NumberFormat('en-IN', { maximumSignificantDigits: 3 }).format(player.amount) }}
          </h3>
        </li>
      </ul>
      <div class="mb-6 text-center text-gray-600" v-else>
        Start by adding 2 or more players
      </div>
      <button
        class="w-full bg-transparent border-2 border-solid border-blue-400 text-blue-400"
        @click="newPlayer.modal = true"
      >
        Add a player
      </button>
    </div>

    <Modal v-model="newPlayer.modal">
      <NFCReader v-model="newPlayer.id" />

      <form @submit.prevent="addPlayer">
        <FormInput type="text" v-model="newPlayer.name" required>
          Name
        </FormInput>
        <FormInput type="number" v-model="newPlayer.amount" required>
          Initial Amount
        </FormInput>
        <FormInput type="text" v-model="newPlayer.id" placeholder="Bring RFID card closer to NFC sensor" disabled>
          Card
        </FormInput>

        <p class="text-center text-red-500 mb-5" v-if="newPlayer.id in players">
          Player already exists.
          <br>
          Try adding a different card.
        </p>

        <button
          class="primary"
          type="submit"
          style="width: 100%"
          :disabled="newPlayer.id in players"
        >
          Add player
        </button>
      </form>
    </Modal>


    <button
      class="primary fixed w-4/6"
      style="bottom: 30px"
      :disabled="Object.keys(players).length < 2"
      @click="startGame"
    >
      Start game!
    </button>
  </div>
</template>

<script>
import Modal from '@/components/Modal.vue';
import FormInput from '@/components/FormInput.vue';
import NFCReader from '@/components/NFCReader.vue';

export default {
  name: 'Home',
  components: {
    Modal,
    FormInput,
    NFCReader,
  },
  data() {
    return {
      newPlayer: {
        modal: false,
        id: '',
        name: '',
        amount: 0,
      },
      players: {},
    }
  },
  methods: {
    addPlayer() {
      if (!this.newPlayer.id) return;

      this.players[this.newPlayer.id] = {
        name: this.newPlayer.name,
        amount: parseInt(this.newPlayer.amount),
        transactions: this.newPlayer.amount ? [{
          type: 'collect',
          amount: this.newPlayer.amount
        }] : []
      };
      
      this.newPlayer = {
        modal: false,
        id: '',
        name: '',
        amount: 0,
      };
    },
    startGame() {
      if (Object.keys(this.players).length < 2) return;

      localStorage.setItem('game', JSON.stringify(this.players));
      this.$router.push('/game');
    }
  },
  created() {
    const game = localStorage.getItem('game');
    if (game) {
      this.players = JSON.parse(game);
    }
  }
}
</script>
