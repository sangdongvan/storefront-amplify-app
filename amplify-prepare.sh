#!/usr/bin/env bash

# Exit on err
set -e

echo '⚙ Prepare target dirs'
rm -rf .amplify-hosting
mkdir -p .amplify-hosting/compute

echo '⚙ Prepare entrypoint for the default compute'
rm -rf dist
# Inject environment variables
cat src-rslib/config.ts.tpl | envsubst > src-rslib/config.gen.ts
npx rslib build

cp -r dist .amplify-hosting/compute/
mv .amplify-hosting/compute/dist .amplify-hosting/compute/default

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
