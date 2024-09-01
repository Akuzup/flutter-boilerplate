#!/bin/bash
set -e
# flutter clean
# rm -rf macos/Pods
rm -rf ios/Pods
# rm -f macos/Podfile.lock
rm -f ios/Podfile.lock
# rm -f pubspec.lock
rm -rf ios/.symlinks
# rm -rf macos/.symlinks
flutter pub get
cd ios && pod deintegrate && pod install && pod update && cd ..
# cd macos && pod deintegrate && pod install && pod update && cd ..
echo "Clean done !!!"