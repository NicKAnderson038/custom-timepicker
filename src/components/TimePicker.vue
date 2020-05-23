<template>
  <div>
    <v-btn icon color="orange" class="caret" @click="show = true">
      <!-- <v-icon color="red" class="caret--size">fas fa-clock</v-icon> -->
      <v-icon class="caret--size">mdi-clock</v-icon>
    </v-btn>
    <v-dialog v-model="show" max-width="360">
      <div class="time--container">
        <v-card>
          <v-card-text
            class="primary text-uppercase headline text-xs-center yellow-height-caret"
          >
            <h2 class="body-1 label--prop">{{ label }}</h2>
            <v-icon
              color="black"
              class="caret times--icon"
              @click.stop="show = false"
              >far fa-times-circle</v-icon
            >
            <v-btn
              icon
              class="caret"
              @click="() => changeTime('INCREASE', 'hour', maxTime)"
            >
              <v-icon color="black" class="caret--size">fas fa-caret-up</v-icon>
            </v-btn>
            <v-btn
              icon
              class="caret"
              @click="() => changeTime('INCREASE', 'minute', '60')"
            >
              <v-icon color="black" class="caret--size">fas fa-caret-up</v-icon>
            </v-btn>
          </v-card-text>
          <v-card-text
            class="primary text-uppercase headline text-xs-center yellow-height"
          >
            <div class="input--rows">
              <v-select
                light
                block
                solo
                v-model="hour"
                :items="hours"
                color="black--text"
                class="black--text time--text"
                menu-props="auto"
                hide-details
              ></v-select>
              <h1 class="colon">:</h1>
              <v-select
                light
                block
                solo
                v-model="minute"
                :items="minutes"
                color="black--text"
                class="black--text time--text"
                menu-props="auto"
              ></v-select>
            </div>
          </v-card-text>
          <v-card-text
            class="primary text-uppercase headline text-xs-center yellow-height-caret yellow-height-caret-last"
          >
            <v-radio-group
              v-if="!time24hr"
              v-model="timeAmPm"
              column
              class="am--pm--radios"
            >
              <v-radio
                color="black"
                class="am--pm--radio"
                label="AM"
                value="AM"
              ></v-radio>
              <v-radio
                color="black"
                class="am--pm--radio"
                label="PM"
                value="PM"
              ></v-radio>
            </v-radio-group>
            <v-btn
              icon
              class="caret"
              @click="() => changeTime('DECREASE', 'hour', maxTime)"
            >
              <v-icon color="black" class="caret--size"
                >fas fa-caret-down</v-icon
              >
            </v-btn>
            <v-btn
              icon
              class="caret"
              @click="() => changeTime('DECREASE', 'minute', '60')"
            >
              <v-icon color="black" class="caret--size"
                >fas fa-caret-down</v-icon
              >
            </v-btn>
          </v-card-text>
          <v-tabs
            :style="{ width: '300px' }"
            fixed-tabs
            color="sbdBlackGrey"
            centered
            slider-color="primary"
            v-model="tab"
            :class="tabUnderline[tabUnderlineIndex]"
          >
            <v-tab
              v-for="(item, i) in items"
              :key="item.tab"
              @click="() => currentTabHandler(item.tab)"
              :class="`tab--placement-${i}`"
              >{{ item.tab }}</v-tab
            >
          </v-tabs>
          <!-- <v-card-actions
            class="sbdBlackGrey"
            :style="{
              paddingBottom: '10px',
              paddingTop: '10px',
              width: '360px',
            }"
          > -->
          <div class="key--pad">
            <div
              class="d-flex flex-row justify-space-between key--row"
              v-for="(numberButtons, i) in keyPad"
              :key="`row-${i}-main`"
            >
              <v-btn
                class="key--btn"
                v-for="numberButton in numberButtons"
                :key="`row-0-${numberButton}`"
                color="sbdLightGrey"
                outlined
                block
                @click="() => captureButtons(numberButton)"
                >{{ numberButton }}</v-btn
              >
            </div>
            <div class="d-flex flex-row justify-space-between key--row--last">
              <v-btn
                class="key--btn"
                color="sbdLightGrey"
                outlined
                block
                @click="() => captureButtons('0')"
                >0</v-btn
              >
              <v-btn
                class="key--btn"
                color="sbdLightGrey"
                outlined
                block
                @click.stop="clear"
                >CLEAR</v-btn
              >
            </div>
          </div>
          <!-- </v-card-actions> -->
        </v-card>
      </div>
    </v-dialog>
  </div>
</template>

<script>
/* eslint-disable indent */
const clockBuilder = time =>
  [...Array(time + 1).keys()].map(max =>
    max.toLocaleString('en-US', {
      minimumIntegerDigits: 2,
      useGrouping: false,
    })
  )

export default {
  name: 'TimePicker',
  props: {
    value: {
      type: String,
      required: true,
    },
    label: String,
    time24hr: Boolean,
  },
  data() {
    return {
      show: false,
      hour: '00',
      hours: clockBuilder(this.time24hr ? 24 : 12),
      minute: '00',
      minutes: clockBuilder(60),
      tab: null,
      tabUnderline: [
        'tabs--placement--underline--onload',
        'tabs--placement--underline',
      ],
      tabUnderlineIndex: 0,
      currentTab: 'hours',
      items: [{ tab: 'hours' }, { tab: 'minutes' }],
      keyPad: [
        ['1', '2', '3'],
        ['4', '5', '6'],
        ['7', '8', '9'],
      ],
      maxTime: this.time24hr ? '24' : '12',
      timeAmPm: 'AM',
    }
  },
  computed: {
    returnTime: {
      get() {
        return this.value
      },
      set(value) {
        this.$emit('input', value)
      },
    },
    cssVars() {
      return {
        '--tab-placement-underline':
          this.tab === 'hours' ? '49px !important' : '153px !important',
      }
    },
  },
  methods: {
    _changeTimeHelper(times, time) {
      return times.reduce((acc, value, i) => {
        if (value === time) {
          acc = i
        }
        return acc
      }, 0)
    },
    _emitTime() {
      this.returnTime = `${this.hour}:${this.minute}`
    },
    currentTabHandler(tab) {
      this.tabUnderlineIndex = 1
      this.currentTab = tab
    },
    captureButtons(e) {
      const times = this.currentTab
      const time = times.slice(0, -1)

      const appendNumber = num => {
        const saveLastChar = this[time].substring(1)
        const saveFirstChar = this[time].slice(0, 1)

        const test1 = saveLastChar + num
        const test2 = num + saveLastChar
        const test3 = saveFirstChar + num
        return this[times].includes(test1)
          ? test1
          : this[times].includes(test2)
          ? test2
          : this[times].includes(test3)
          ? test3
          : this[time]
      }

      this[time] = appendNumber(e)
      this._emitTime()
    },
    changeTime(action, time, max) {
      if (action === 'INCREASE' && this[time] === max) {
        this[time] = '00'
      } else if (action === 'DECREASE' && this[time] === '00') {
        this[time] = max
      } else if (action === 'INCREASE') {
        this[time] = this[time + 's'][
          this._changeTimeHelper(this[time + 's'], this[time]) + 1
        ]
      } else if (action === 'DECREASE') {
        this[time] = this[time + 's'][
          this._changeTimeHelper(this[time + 's'], this[time]) - 1
        ]
      }
      this._emitTime()
    },
    clear() {
      this.minute = '00'
      this.hour = '00'
      this._emitTime()
    },
  },
}
</script>

<style>
.time--container {
  max-width: 400px;
}

/* Label prop */
.label--prop {
  position: absolute;
  color: black;
  padding-left: 6px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  max-width: 100px;
  user-select: none;
}

/* Carets */
.yellow-height-caret {
  height: 100%;
  padding: 0;
  margin: 0;
}

.yellow-height {
  max-height: 124px;
}

.yellow-height-caret-last {
  padding-bottom: 10px;
}

.caret {
  margin-left: 34px;
  margin-right: 34px;
}

.caret--size {
  font-size: 45px;
}

/* Close modal icon */
.times--icon {
  position: absolute;
  display: block;
  left: 80%;
  padding: 6px;
}

/* 12hour AM/PM radios */
.am--pm--radios {
  position: absolute;
  display: inline;
  left: 80%;
  top: 13%;
}

.am--pm--radio > .v-input--selection-controls__input > i {
  color: #000;
}

.am--pm--radio > .v-label {
  color: #000;
}

.input--rows > .v-text-field {
  max-width: 80px;
}

/* HH:mm colon*/
.colon {
  color: #fff;
  padding-left: 6px;
  padding-right: 6px;
  position: relative;
  top: 35px;
  user-select: none;
}

/* primary container */
.time--text > .v-input__control > .v-input__slot {
  min-height: 100px;
}

.time--container
  > .v-card
  > .v-card__text
  > .time--text-switch.v-input--selection-controls {
  margin: 0;
  padding: 0;
  height: 30px;
  left: 72%;
  position: relative;
}

.time--container
  > .v-card
  > .v-card__text
  > .time--text-switch
  > .v-input__control
  > .v-input__slot
  > label {
  color: black !important;
}

.input--rows {
  display: flex;
  justify-content: center;
}

/* Dropdown */
.time--text
  > .v-input__control
  > .v-input__slot
  > .v-text-field__slot
  > .theme--dark.v-label {
  color: black !important;
}

.time--text
  > .v-input__control
  > .v-input__slot
  > .v-select__slot
  > .v-select__selections {
  color: black !important;
  font-size: 42px;
  top: 14px;
  position: absolute;
}
.time--text
  > .v-input__control
  > .v-input__slot
  > .v-select__slot
  > .v-input__append-inner {
  left: 36px;
  position: absolute;
  display: none;
}

/* Tab placement */
.tabs--placement--underline--onload
  > .v-tabs__bar
  > .v-tabs__wrapper
  > .v-tabs__container
  > .v-tabs__slider-wrapper {
  width: 80px !important;
  margin-left: 40px !important;
  left: var(--tab-placement-underline);
  left: 49px !important;
}

.tabs--placement--underline
  > .v-tabs__bar
  > .v-tabs__wrapper
  > .v-tabs__container
  > .v-tabs__slider-wrapper {
  width: 80px !important;
  margin-left: 40px !important;
  left: var(--tab-placement-underline);
}

.tab--placement-0 {
  position: absolute;
  left: 13.5%;
}

.tab--placement-1 {
  position: absolute;
  left: 42.5%;
}

/* Key Pad */
.key--pad {
  width: 100%;
}

.key--row {
  padding: 5px 10px 5px 10px;
  max-width: 126px;
}

.key--row--last {
  padding: 5px 10px 5px 10px;
  max-width: 183px;
}

.key--btn {
  margin: 4px;
}
</style>
