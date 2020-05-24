publicPath="$(git config --get remote.origin.url | sed 's:.*/::' | cut -f1 -d".")"
export PUBLIC_PATH="/$publicPath/"
echo "📰 Github pages path: $publicPath"

echo "📦 Building application"
vue-cli-service build
echo "🏁 Build complete"

export PUBLIC_PATH='/'
echo "🔙 restore path"

echo "🚀 Begin deployment"
### (Skip if first deployment) rm gh-pages and redo steps above for changes
git push origin --delete gh-pages

git add -f dist && git commit -m "Initial dist subtree commit" --no-verify

git subtree push --prefix dist origin gh-pages

echo "🛁 Clean up process"
rm -r -v dist
git rm -r --cached dist
git add .
git commit -m "cleaned cache"
git push

exit 0
read