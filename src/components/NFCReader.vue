<template>
  
</template>

<script>
export default {
  name: 'NFCReader',
  created() {
    
    try {
      const reader = new NDEFReader();

      reader.scan().then(() => {
        console.log("Scan started successfully.");
        reader.onerror = () => {
          console.log("Cannot read data from the NFC tag. Try another one?");
        };
        reader.onreading = event => {
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