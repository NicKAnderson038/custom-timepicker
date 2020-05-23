# custom-timepicker

## Project setup

```
yarn install || npm install
```

### Compiles and hot-reloads for development

```
yarn serve || npm run serve
```

### Compiles and minifies for production

```
yarn build || npm run build
```

### Lints and fixes files

```
yarn lint || npm run lint
```

### Customize configuration

See [Configuration Reference](https://cli.vuejs.org/config/).

### Deploying to GitHub [Pages](https://nickanderson038.github.io/custom-timepicker/).

1. Follow <a href="https://medium.com/@Roli_Dori/deploy-vue-cli-3-project-to-github-pages-ebeda0705fbd" target="_blank">instructions</a> on deployment.
2. Make sure to add the `--no-verify` flag to end of the `git commit` step.
3. command steps:

```bash
npm run build || yarn build

git add dist && git commit -m "Initial dist subtree commit" --no-verify

# 1st time creation:
git subtree push -u --prefix dist origin gh-pages

# Every time after:
git subtree push --prefix dist origin gh-pages
```

#
