<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<style>

  * {
    box-sizing: border-box;
  }

  body {
    margin: 0;
    font-family: 'Poppins', sans-serif;
    font-weight: 500;
  }

  button {
    font-family: 'Poppins', sans-serif;
    font-weight: 500;
    padding: 0.75rem 1rem;
    border-radius: 4px;
    border: none;
    outline: none;
    cursor: pointer;
    font-size: 1.1rem;
  }
  button:disabled {
    opacity: 0.5;
  }
  button.primary {
    background-color: #63b3ed;
    color: #ffffff;
    box-shadow: 0 10px 15px -3px rgba(99, 179, 237,.1),0 4px 6px -2px rgba(99, 179, 237,.06);
  }

  input {
    width: 100%;
    padding: 0.75rem;
    font-family: 'Poppins', sans-serif;
    border-radius: 4px;
    outline: none;
    border: 1px solid #CBD5E0;
    color: #2D3748;
  }
  input:disabled {
    background-color: #EDF2F7;
  }

</style>