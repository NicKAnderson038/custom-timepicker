<template>
  <v-app>
    <v-app-bar app color="dark-grey" dark>
      <div class="d-flex align-center">
        <v-img
          alt="GitHub Logo"
          class="shrink mr-2"
          contain
          src="https://img.icons8.com/bubbles/2x/github.png"
          transition="scale-transition"
          width="40"
        />
      </div>

      <v-spacer></v-spacer>

      <v-btn
        href="https://github.com/NicKAnderson038/custom-timepicker"
        target="_blank"
        text
      >
        <span class="mr-2">GitHub</span>
        <v-icon>mdi-open-in-new</v-icon>
      </v-btn>
    </v-app-bar>

    <v-content>
      <CardComponent />
    </v-content>
  </v-app>
</template>

<script>
import CardComponent from './components/CardComponent'

export default {
  name: 'App',

  components: {
    CardComponent,
  },

  data: () => ({
    //
  }),
}
</script>
