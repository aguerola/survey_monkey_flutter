#!/usr/bin/env bash

rm build/app/outputs/bundle/productionRelease/app.aab
flutter build appbundle --target-platform android-arm,android-arm64 --flavor production -t lib/main_production.dart


if [[ -f "build/app/outputs/bundle/productionRelease/app.aab" ]]
then
	cd android
    fastlane supply --track alpha --aab ../build/app/outputs/bundle/productionRelease/app.aab --skip_upload_metadata true --skip_upload_images true --skip_upload_screenshots true
else
	echo "aab file not found."
fi