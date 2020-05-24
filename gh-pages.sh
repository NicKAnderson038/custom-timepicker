# UPDATE with application name
newPath='/custom-timepicker/'

export PUBLIC_PATH=$newPath
echo "📰 Github pages path: $newPath"
# node --print 'process.env.PUBLIC_PATH'

### Build application
echo "📦 Build application"
yon build
echo "🏁 Build complete"

export PUBLIC_PATH='/'
echo "🔙 restore path"
# node --print 'process.env.PUBLIC_PATH'

echo "🚀 Begin deployment"
### (Skip if first deployment) rm gh-pages and redo steps above for changes
git push origin --delete gh-pages

git rm -r --cached dist

git add dist && git commit -m "Initial dist subtree commit" --no-verify

git subtree push --prefix dist origin gh-pages

rm -r -v dist

git rm -r --cached
exit 0
read