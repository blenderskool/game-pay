<template>
  <audio ref="scan" hidden>
    <source src="/scan.mp3" type="audio/mpeg">
  </audio>
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
  created() {
    
    try {
      const reader = new NDEFReader();

      reader.scan().then(() => {
        console.log("Scan started successfully.");
        reader.onerror = () => {
          console.log("Cannot read data from the NFC tag. Try another one?");
        };
        reader.onreading = event => {
          // Play scan audio
          if (!this.silent) {
            this.$refs.scan.play();
          }

          // Emit the serial number of the tag
          this.$emit('input', event.serialNumber);
        };
      }).catch(error => {
        console.log(`Error! Scan failed to start: ${error}.`);
      });

    } catch (e) {
      console.log(e);
    }
  }
}
</script>