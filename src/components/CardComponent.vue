<template>
  <v-container>
    <v-card class="mx-auto" max-width="400">
      <v-img
        class="white--text align-end"
        height="200px"
        src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
      >
        <v-card-title>{{ title.toUpperCase() }}</v-card-title>
      </v-img>
      <v-card-subtitle class="pb-0">
        <v-icon class="caret--size">mdi-clock</v-icon>
        {{ subTitle }}
      </v-card-subtitle>
      <v-card-text class="text--primary">
        <ul v-for="feature in features" :key="feature.replace(/ /, '-')">
          <li>{{ feature }}</li>
        </ul>
      </v-card-text>
      <v-card-actions>
        <v-text-field
          readonly
          :label="labels[0]"
          :color="color[0]"
          :value="timePicker1"
        ></v-text-field>
        <TimePicker
          v-model="timePicker1"
          :label="labels[0]"
          :time24hr="true"
          :color="color[0]"
        />
        <v-text-field
          readonly
          :label="labels[1]"
          :color="color[1]"
          :value="timePicker2"
        ></v-text-field>
        <TimePicker
          v-model="timePicker2"
          :label="labels[0]"
          :time24hr="true"
          :color="color[1]"
        />
      </v-card-actions>
      <v-card-actions>
        <v-text-field
          readonly
          :label="labels[0]"
          :color="color[2]"
          :value="timePicker3"
        ></v-text-field>
        <TimePicker
          v-model="timePicker3"
          :label="labels[0]"
          :time24hr="false"
          :color="color[2]"
        />
        <v-text-field
          readonly
          :label="labels[1]"
          :color="color[3]"
          :value="timePicker4"
        ></v-text-field>
        <TimePicker
          v-model="timePicker4"
          :label="labels[0]"
          :time24hr="false"
          :color="color[3]"
        />
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
    title: 'Custom Time Picker',
    subTitle: 'Time Picker Features',
    color: ['success', 'error', 'primary', 'warning'],
    labels: ['Start Time', 'End Time'],
    timePicker1: '',
    timePicker2: '',
    timePicker3: '',
    timePicker4: '',
    features: [
      'Automatic time validation',
      '24hr and 12hr time formats',
      'Primary colors (blue, red, green, orange)',
    ],
  }),
}
</script>
