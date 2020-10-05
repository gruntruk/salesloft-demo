<template>
  <div id="people-view">
    <h2>SalesLoft People View</h2>

    <div class="clear-fix">
      <div class="spinner-border float-right" role="status" v-if="isLoading">
        <span class="sr-only">Loading...</span>
      </div>
    </div>

    <ul class="nav">
      <li class="nav-item">
        <a id="people-view-view" class="nav-link active" href="#" v-on:click="currentView = 'people-view'">People</a>
      </li>
      <li class="nav-item">
        <a id="frequency-view" class="nav-link" href="#" v-on:click="openFrequencyView">Frequency Count</a>
      </li>
      <li>
        <a id="dupe-view" class="nav-link" href="#" v-on:click="currentView = 'dupe-view'">Duplicates</a>
      </li>
    </ul>

    <people-grid v-bind:data="people" v-if="currentView === 'people-view'" />

    <frequency-view v-bind:data="frequencySummary" v-if="currentView === 'frequency-view'"/>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data () {
    return { people: [], currentView: 'people-view', frequencySummary: [], isLoading: false }
  },
  methods: {
    openFrequencyView (event) {
      axios
        .get('/api/people/frequency_count')
        .then(response => {
          this.frequencySummary = response.data.data;
          this.currentView = 'frequency-view';
        })
    }
  },
  mounted () {
    axios.interceptors.request.use((config) => {
      this.isLoading = true;
      return config;
    }, (error) => {
      this.isLoading = false;
      return Promise.reject(error);
    })

    axios.interceptors.response.use((response) => {
      this.isLoading = false;
      return response;
    }, (error) => {
      this.isLoading = false;
      return Promise.reject(error);
    });
    axios
      .get('/api/people')
      .then(response => {
        this.people = response.data.data;
      })
  }
}
</script>
