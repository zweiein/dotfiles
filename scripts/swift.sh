#!/usr/bin/env bash

# Clones swift in the current directory.
# .
# ├── build
# ├── clang
# ├── cmark
# ├── llvm
# └── swift

export SWIFT_SOURCE_ROOT=$(pwd)
export SWIFT_BUILD_ROOT=$(pwd)/build

SWIFT_CLANG_ROOT=$SWIFT_SOURCE_ROOT/clang
SWIFT_CMARK_ROOT=$SWIFT_SOURCE_ROOT/cmark
SWIFT_LLDB_ROOT=$SWIFT_SOURCE_ROOT/lldb
SWIFT_LLVM_ROOT=$SWIFT_SOURCE_ROOT/llvm
SWIFT_SWIFT_ROOT=$SWIFT_SOURCE_ROOT/swift
SWIFT_SWIFTPM_ROOT=$SWIFT_SOURCE_ROOT/swiftpm
SWIFT_LLBUILD_ROOT=$SWIFT_SOURCE_ROOT/llbuild

info() {
  printf "\033[00;34m$@\033[0m\n"
}

cd "$SWIFT_SOURCE_ROOT" || exit

info "Cloning repositories"

git clone git@github.com:apple/swift-clang.git "$SWIFT_CLANG_ROOT" &> /dev/null &
git clone git@github.com:apple/swift-cmark.git "$SWIFT_CMARK_ROOT" &> /dev/null &
git clone git@github.com:apple/swift-lldb.git "$SWIFT_LLDB_ROOT" &> /dev/null &
git clone git@github.com:apple/swift-llvm.git "$SWIFT_LLVM_ROOT" &> /dev/null &
git clone git@github.com:apple/swift.git "$SWIFT_SWIFT_ROOT" &> /dev/null &

git clone git@github.com:apple/swift-package-manager.git "$SWIFT_SWIFTPM_ROOT" &> /dev/null &
git clone git@github.com:apple/swift-llbuild.git "$SWIFT_LLBUILD_ROOT" &> /dev/null &

git clone git@github.com:apple/swift-corelibs-foundation.git &> /dev/null &
git clone git@github.com:apple/swift-corelibs-libdispatch.git &> /dev/null &
git clone git@github.com:apple/swift-corelibs-xctest.git &> /dev/null &

wait

info "Updating checkout"
"$SWIFT_SWIFT_ROOT/utils/update-checkout" --scheme=master --reset-to-remote

if [ $# -ne 0 ]; then
  info "Invoking build script"
  "$SWIFT_SWIFT_ROOT/utils/build-script" "$@"
fi
