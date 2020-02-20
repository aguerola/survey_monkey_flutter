#!/usr/bin/env bash
flutter drive --flavor=development --target=test_driver/home_app.dart -d 'iPhone 8 Plus'
flutter drive --flavor=development --target=test_driver/activity_app.dart -d 'iPhone 8 Plus'
flutter drive --flavor=development --target=test_driver/community_app.dart -d 'iPhone 8 Plus'