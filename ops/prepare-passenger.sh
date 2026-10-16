#!/bin/sh
set -eu
# Run as root after installing Passenger and the application's Ruby runtime.
# Prebuild outside Apache's read-only home-directory namespace.
app_user=${1:-ss-calculator}
exec runuser -u "$app_user" -- env \
  RUBYLIB=/usr/lib/ruby/vendor_ruby \
  PATH=/opt/ruby/3.4.11/bin:/usr/local/bin:/usr/bin:/bin \
  /opt/ruby/3.4.11/bin/ruby /usr/bin/passenger-config build-native-support
