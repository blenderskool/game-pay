<template>
</template>

<script>

export default {
  name: 'NFCReader',
  props: {
    silent: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      reader: new NDEFReader(),
    }
  },
  methods: {
    handleReading(event) {
      // Play scan audio
      if (!this.silent) {
        const audio = new Audio('/scan.mp3');
        audio.play();
      }

      setTimeout(() => {
        // Emit the serial number of the tag
        this.$emit('input', event.serialNumber);
      }, this.silent ? 550 : 0);
    },
    handleError() {
      console.log("Cannot read data from the NFC tag. Try another one?");
    },
  },
  created() {
    try {

      this.reader.scan().then(() => {
        console.log("Scan started successfully.");
        this.reader.addEventListener('error', this.handleError);
        this.reader.addEventListener('reading', this.handleReading);
      }).catch(error => {
        console.log(`Error! Scan failed to start: ${error}.`);
      });

    } catch (e) {
      console.log(e);
    }
  },
  beforeDestroy() {
    this.reader.removeEventListener('error', this.handleError);
    this.reader.removeEventListener('reading', this.handleReading);
  },
}
</script>