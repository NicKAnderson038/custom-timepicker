echo "Begin deployment ⚙️"

# UPDATE with application name
newPath='/custom-timepicker/'

restoredPath='/'

export PUBLIC_PATH=$newPath
echo "GITHUB PAGES PATH 📰: $newPath"
# node --print 'process.env.PUBLIC_PATH'

# Build application
yon build

export PUBLIC_PATH=$restoredPath
echo "RESTORED PATH 🔙: $restoredPath"
# node --print 'process.env.PUBLIC_PATH'

# (Skip if first deployment) rm gh-pages and redo steps above for changes
git push origin --delete gh-pages

git add -f dist && git commit -m "Initial dist subtree commit" --no-verify

git subtree push --prefix dist origin gh-pages

echo "Deployment complete 📦"
exit 0
read