<template>
    <table class="table table-striped">
      <caption>{{ data.length }} results</caption>
      <thead>
        <tr>
          <th>Name</th>
          <th>Email</th>
          <th>Job Title</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="person in data" :key="person.id">
          <td>{{ person.display_name }}</td>
          <td>{{ person.email_address }}</td>
          <td>{{ person.title }}</td>
        </tr>
      </tbody>
    </table>
</template>

<script>
export default {
  props: ['data']
}
</script>