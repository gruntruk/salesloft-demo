<template>
    <table class="table table-striped table-sm">
      <caption>{{ data.length }} results</caption>
      <thead>
        <tr>
          <th>Character</th>
          <th># Occurrences</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="tuple in data" :key="tuple[0]">
          <td>{{ tuple[0] }}</td>
          <td>{{ tuple[1] }}</td>
        </tr>
      </tbody>
    </table>
</template>

<script>
export default {
  props: ['data']
}
</script>