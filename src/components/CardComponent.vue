<template>
  <v-container>
    <v-card class="mx-auto" max-width="400">
      <v-img
        class="white--text align-end"
        height="200px"
        src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
      >
        <v-card-title>Top 10 Australian beaches</v-card-title>
      </v-img>

      <v-card-subtitle class="pb-0">Number 10</v-card-subtitle>

      <v-card-text class="text--primary">
        <div>Whitehaven Beach</div>

        <div>Whitsunday Island, Whitsunday Islands</div>
      </v-card-text>

      <v-card-actions>
        <v-btn color="orange" text>Share</v-btn>
        {{ timePicker1 }}
        <TimePicker
          v-model="timePicker1"
          :label="'END TIME'"
          :time24hr="true"
        />

        <v-btn color="orange" text>Explore</v-btn>
      </v-card-actions>
    </v-card>
  </v-container>
</template>

<script>
import TimePicker from './TimePicker'
export default {
  name: 'CardComponent',
  components: {
    TimePicker,
  },

  data: () => ({
    timePicker1: '',
  }),
}
</script>
