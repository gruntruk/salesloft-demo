<template>
  <div id="people-view">
    <h2>SalesLoft People View</h2>
    <people-grid v-bind:data="people"/>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data () {
    return { people: [] }
  },
  mounted () {
    axios
      .get('/api/people')
      .then(response => {
        this.people = response.data.data;
      })
  }
}
</script>
