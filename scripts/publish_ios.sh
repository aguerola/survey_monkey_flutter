#!/usr/bin/env bash


rm -rf "${HOME}/Library/Caches/CocoaPods"
cd ios
rm -Rf Pods; pod install
cd ..

#flutter build ios --flavor production -t lib/main_production.dart --no-codesign

#cd ios

#fastlane beta