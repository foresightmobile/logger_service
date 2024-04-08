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
  flutter analyze --no-pub .
  flutter test
  
  cd -
}

###############################################################################
# INVOKE VERIFICATION FUNCTIONS
###############################################################################
verifyFlutter "."
