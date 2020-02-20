#!/usr/bin/env bash


rm -rf "${HOME}/Library/Caches/CocoaPods"
cd ios
rm -Rf Pods; pod install
cd ..
