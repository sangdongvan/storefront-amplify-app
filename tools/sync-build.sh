#!/usr/bin/env bash

# Exit on err
set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

echo "SCRIPT_DIR=$SCRIPT_DIR"

STOREFRONT_DIR="$SCRIPT_DIR/../../storefront"
AMPLIFY_APP_DIR="$SCRIPT_DIR/../"

echo "Clear webapp build"
rm -rf $AMPLIFY_APP_DIR/src/server || true
rm -rf $AMPLIFY_APP_DIR/src/client || true

echo "Sync webapp build"
cp -r $STOREFRONT_DIR/apps/webapp/build/server $AMPLIFY_APP_DIR/src
cp -r $STOREFRONT_DIR/apps/webapp/build/client $AMPLIFY_APP_DIR/src

echo "✅ Done"
