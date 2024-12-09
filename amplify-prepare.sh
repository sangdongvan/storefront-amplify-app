#!/usr/bin/env bash

# Exit on err
set -e

echo '⚙ Prepare target dirs'
rm -rf .amplify-hosting

echo '⚙ Prepare entrypoint for the default compute'
rm -rf dist
# Inject environment variables
cat src/config.js.tpl | envsubst > src/config.gen.js

mkdir -p .amplify-hosting/compute/default
cp -r src/server .amplify-hosting/compute/default
cp src/config.gen.js .amplify-hosting/compute/default
cp src/serve.js .amplify-hosting/compute/default

echo '⚙ Install runtime dependencies'
# Install runtime node_modules, keep runtime small, only express.js for now.
# Note that package.json with type module is required to load es module.
cp src/package.json .amplify-hosting/compute/default/
pushd .
cd .amplify-hosting/compute/default
npm install
popd

echo '⚙ Copy static'
cp -r src/client .amplify-hosting/
mv .amplify-hosting/client .amplify-hosting/static

echo '⚙ Prepare manifest'
cp src/deploy-manifest.json .amplify-hosting/deploy-manifest.json

echo '✅ Done'
