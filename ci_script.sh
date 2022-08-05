#!/bin/bash
set -e # exit on first error

###############################################################################
# VERIFICATION FUNCTION FOR FLUTTER APP/PACKAGES
###############################################################################
verifyFlutter () {
  cd $1
  echo "Checking `pwd`"
  
  flutter clean
  flutter pub get
  flutter format --set-exit-if-changed .
  flutter pub run dart_code_metrics:metrics analyze . --fatal-style --fatal-performance --fatal-warnings
  flutter pub run dart_code_metrics:metrics check-unused-files . --fatal-unused 
  flutter pub run dart_code_metrics:metrics check-unused-l10n . --fatal-unused 
  flutter pub run dart_code_metrics:metrics check-unused-code . --fatal-unused 
  flutter analyze --no-pub .
  flutter test
  
  cd -
}

###############################################################################
# INVOKE VERIFICATION FUNCTIONS
###############################################################################
verifyFlutter "."
