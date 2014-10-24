#!/usr/bin/env zsh

# custom rustc builds and bindgen need to link with libclan from here
libs=$(xcode-select --print-path)/Toolchains/XcodeDefault.xctoolchain/usr/lib
export DYLD_LIBRARY_PATH=$libs:$DYLD_LIBRARY_PATH
