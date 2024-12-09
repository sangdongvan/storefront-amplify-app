#!/usr/bin/env bash

# Exit on err
set -e

echo '⚙ Prepare target dirs'
rm -rf .amplify-hosting

echo '⚙ Prepare entrypoint for the default compute'
rm -rf dist
# Inject environment variables
cat src-rslib/config.js.tpl | envsubst > src-rslib/config.gen.js

mkdir -p .amplify-hosting/compute/default
cp -r src-rslib/server .amplify-hosting/compute/default
cp src-rslib/config.gen.js .amplify-hosting/compute/default
cp src-rslib/serve.js .amplify-hosting/compute/default

echo '⚙ Install runtime dependencies'
# Install runtime node_modules, keep runtime small, only express.js for now.
# Note that package.json with type module is required to load es module.
cp src-amplify/package.json .amplify-hosting/compute/default/
pushd .
cd .amplify-hosting/compute/default
npm install
popd

echo '⚙ Copy static'
cp -r src-amplify/client .amplify-hosting/
mv .amplify-hosting/client .amplify-hosting/static

echo '⚙ Prepare manifest'
cp src-amplify/deploy-manifest.json .amplify-hosting/deploy-manifest.json

echo '✅ Done'
