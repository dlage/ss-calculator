#!/bin/sh
set -eu
version=3.4.11
sha256=5c22be44524312b3d433d68739bcc530633b1da5ef8ba0afa0a37680da17d3de
prefix=/opt/ruby/$version
if test -x "$prefix/bin/ruby"; then
  "$prefix/bin/ruby" --version
  exit 0
fi
build_dir=$(mktemp -d /tmp/ss-calculator-ruby.XXXXXX)
trap 'rm -rf "$build_dir"' EXIT
cd "$build_dir"
curl --fail --location --retry 3 -o ruby.tar.gz "https://cache.ruby-lang.org/pub/ruby/3.4/ruby-$version.tar.gz"
printf '%s  ruby.tar.gz\n' "$sha256" | sha256sum --check
# Dependencies: build-essential libssl-dev libyaml-dev zlib1g-dev libreadline-dev.
tar -xzf ruby.tar.gz
cd "ruby-$version"
./configure --prefix="$prefix" --enable-shared --disable-install-doc --disable-yjit
make -j "${BUILD_JOBS:-4}"
make install
"$prefix/bin/ruby" --version
