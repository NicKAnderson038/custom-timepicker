module.exports = {
  transpileDependencies: ['vuetify'],
  // publicPath: '/custom-timepicker/',
  publicPath: process.env.PUBLIC_PATH ? '/custom-timepicker/' : '/',
}

console.log('TEST TEST TEST: ', process.env.PUBLIC_PATH)
