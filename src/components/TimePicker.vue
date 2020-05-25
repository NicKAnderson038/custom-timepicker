<template>
  <div>
    <v-btn icon :color="color" @click="show = true">
      <v-icon class="caret--size">mdi-clock</v-icon>
    </v-btn>
    <v-dialog v-model="show" max-width="400">
      <div class="time--container">
        <v-card>
          <div
            :class="
              `${color} text-uppercase headline text-xs-center yellow-height-caret`
            "
          >
            <h2 class="body-1 label--prop">{{ label.toUpperCase() }}</h2>
            <v-icon
              color="black"
              class="caret times--icon"
              @click.stop="show = false"
              >fas fa-times-circle</v-icon
            >
            <div class="d-flex flex-row justify-center">
              <v-btn
                icon
                class="caret"
                @click="() => changeTime('INCREASE', 'hour', maxTime, true)"
              >
                <v-icon color="black" class="caret--size"
                  >fas fa-caret-up</v-icon
                >
              </v-btn>
              <v-btn
                icon
                class="caret"
                @click="() => changeTime('INCREASE', 'minute', '60', false)"
              >
                <v-icon color="black" class="caret--size"
                  >fas fa-caret-up</v-icon
                >
              </v-btn>
            </div>
          </div>
          <!-- </v-card-text> -->
          <v-card-text
            :class="
              `${color} text-uppercase headline text-xs-center yellow-height`
            "
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
                @change="timeSelected = true"
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
                @change="timeSelected = false"
              ></v-select>
            </div>
          </v-card-text>
          <v-card-text
            :class="
              `${color} text-uppercase headline text-xs-center yellow-height-caret yellow-height-caret-last`
            "
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
            <div class="d-flex flex-row justify-center">
              <v-btn
                icon
                class="caret"
                @click="() => changeTime('DECREASE', 'hour', maxTime, true)"
              >
                <v-icon color="black" class="caret--size"
                  >fas fa-caret-down</v-icon
                >
              </v-btn>
              <v-btn
                icon
                class="caret"
                @click="() => changeTime('DECREASE', 'minute', '60', false)"
              >
                <v-icon color="black" class="caret--size"
                  >fas fa-caret-down</v-icon
                >
              </v-btn>
            </div>
          </v-card-text>
          <div class="key--pad">
            <div class="d-flex flex-row justify-center">
              <v-btn
                :style="{ left: '4px' }"
                class="key--btn"
                text
                :outlined="timeSelected"
                color="orange"
                @click="() => currentTabHandler(time[0])"
                >{{ time[0] }}</v-btn
              >
              <v-btn
                :style="{ left: '7px' }"
                class="key--btn"
                text
                :outlined="!timeSelected"
                color="orange"
                @click="() => currentTabHandler(time[1])"
                >{{ time[1] }}</v-btn
              >
            </div>
            <div class="key--rows">
              <div
                class="key--row"
                v-for="(numberButtons, i) in keyPad"
                :key="`row-${i}-main`"
              >
                <v-btn
                  class="key--btn"
                  v-for="numberButton in numberButtons"
                  :key="`row-0-${numberButton}`"
                  :color="color"
                  outlined
                  block
                  large
                  @click="() => captureButtons(numberButton)"
                >
                  <span :style="{ color: 'black' }">{{ numberButton }}</span>
                </v-btn>
              </div>
            </div>
            <div
              class="key--row--last"
              v-for="(numberButtons, i) in keyPadEnd"
              :key="`row-${i}-main`"
            >
              <v-btn
                class="key--btn"
                v-for="numberButton in numberButtons"
                :key="`row-0-${numberButton}`"
                :color="color"
                outlined
                block
                large
                @click="
                  () =>
                    numberButton === '0'
                      ? captureButtons(numberButton)
                      : clear(numberButton)
                "
              >
                <span :style="{ color: 'black' }">{{ numberButton }}</span>
              </v-btn>
            </div>
          </div>
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
    color: {
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
      time: ['hours', 'minutes'],
      timeSelected: true,
      keyPad: [
        ['1', '4', '7'],
        ['2', '5', '8'],
        ['3', '6', '9'],
      ],
      keyPadEnd: [['0', 'Clear']],
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
      this.returnTime = this.time24hr
        ? `${this.hour}:${this.minute}`
        : `${this.hour}:${this.minute} ${this.timeAmPm}`
    },
    currentTabHandler(tab) {
      this.tabUnderlineIndex = 1
      this.currentTab = tab
      this.timeSelected = !this.timeSelected
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
    changeTime(action, time, max, bool) {
      this.timeSelected = bool
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
      this.returnTime = ''
      this.timeAmPm = 'AM'
      this.timeSelected = true
    },
  },
}
</script>

<style>
.time--container {
  max-width: 400px;
  overflow-x: hidden;
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
  top: 17.5%;
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
  top: 30px;
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
  > .v-select__slot
  > .v-select__selections {
  font-size: 50px;
}

.time--text
  > .v-input__control
  > .v-input__slot
  > .v-select__slot
  > .v-select__selections
  > .v-select__selection--comma {
  overflow: inherit;
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

/* Key Pad */
.key--pad {
  width: 100%;
}

.key--rows {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

.key--row {
  padding: 2px 10px 2px 2px;
  width: 100%;
}

.key--row--last {
  padding: 2px 10px 2px 2px;
  display: flex;
  width: 50.5%;
}

.key--btn {
  margin: 4px;
}
</style>
