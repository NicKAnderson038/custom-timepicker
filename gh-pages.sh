echo "⚙️ Begin deployment"

# UPDATE with application name
newPath='/custom-timepicker/'

export PUBLIC_PATH=$newPath
echo "📰 GITHUB PAGES PATH: $newPath"
# node --print 'process.env.PUBLIC_PATH'

### Build application
yon build

export PUBLIC_PATH='/'
echo "🔙 RESTORED PATH"
# node --print 'process.env.PUBLIC_PATH'

### (Skip if first deployment) rm gh-pages and redo steps above for changes
git push origin --delete gh-pages

git rm -r --cached dist

git add -f dist && git commit -m "Initial dist subtree commit" --no-verify

git subtree push --prefix dist origin gh-pages

echo "📦 Deployment complete"
echo "📁 Delete dist folder"
rm -r -v dist

exit 0
read