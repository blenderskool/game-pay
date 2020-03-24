<template>
  <div class="home">
    
    <div class="players">
      <ul>
        <li :key="i" v-for="(player, i) in players">
          <h2>{{ player.name }}</h2>
          <h3>
            +{{ new Intl.NumberFormat('en-IN', { maximumSignificantDigits: 3 }).format(player.amount) }}
          </h3>
        </li>
      </ul>
      <button class="add-player" @click="newPlayer.modal = true">
        Add a player
      </button>
    </div>

    <Modal v-model="newPlayer.modal">
      <NFCReader v-model="newPlayer.id" />

      <form @submit.prevent="addPlayer">
        <label>
          Name*
          <input type="text" v-model="newPlayer.name" required>
        </label>
        <label>
          Amount*
          <input type="number" v-model="newPlayer.amount" required>
        </label>
        <label>
          Card
          <input type="text" v-model="newPlayer.id" disabled>
        </label>
        <button class="primary" type="submit" style="width: 100%">
          Add player
        </button>
      </form>
    </Modal>


    <button class="primary start-game" :disabled="players.length < 2">
      Start game!
    </button>
  </div>
</template>

<script>
import Modal from '@/components/Modal.vue';
import NFCReader from '@/components/NFCReader.vue';

export default {
  name: 'Home',
  components: {
    Modal,
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
      players: [],
    }
  },
  methods: {
    addPlayer() {
      this.players.push({
        name: this.newPlayer.name,
        id: this.newPlayer.id,
        amount: this.newPlayer.amount,
        transactions: this.newPlayer.amount ? [{
          type: 'collect',
          amount: this.newPlayer.amount
        }] : []
      });
      
      this.newPlayer = {
        modal: false,
        id: '',
        name: '',
        amount: 0,
      };
    }
  }
}
</script>

<style scoped>

  .home {
    background-color: #EDF2F7;
    height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  .players {
    background-color: #ffffff;
    padding: 1.25rem;
    border-radius: 4px;
    box-shadow: 0 20px 25px -5px rgba(0,0,0,.1),0 10px 10px -5px rgba(0,0,0,.04);
    width: 75%;
  }

  .players ul {
    padding: 0;
    margin: 0 0 1.5rem;
    list-style: none;
  }
  .players ul:empty::before {
    content: 'Start by adding 2 players';
    text-align: center;
    width: 100%;
    display: block;
    color: #718096;
  }

  .players li {
    padding: 0.5rem;
    display: flex;
  }
  .players li h2 {
    margin: 0;
    font-weight: 500;
    font-size: 1.25rem;
  }
  .players li h3 {
    margin: 0;
    font-weight: 600;
    margin-left: auto;
    font-size: 1rem;
    color: #48BB78;
  }
  
  .add-player {
    width: 100%;
    background-color: transparent;
    border: 2px solid #BEE3F8;
    color: #63B3ED;
  }

  .start-game {
    position: fixed;
    bottom: 30px;
    width: 66%;
  }

  form label {
    color: #4A5568;
    display: block;
    margin: 1rem 0;
  }

</style>
