#!/usr/bin/env bash

set -x
set -e
set -u

HERE="$(cd $(dirname $0) && pwd)"
. ${HERE}/buildbot_functions.sh

ROOT=`pwd`
PLATFORM=`uname`
export PATH="/usr/local/bin:$PATH"

CHECK_LIBCXX=${CHECK_LIBCXX:-1}
CHECK_LLD=${CHECK_LLD:-1}
STAGE1_DIR=llvm_build0
LLVM=$ROOT/llvm
CMAKE_COMMON_OPTIONS="-GNinja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_PARALLEL_COMPILE_JOBS=100 -DLLVM_PARALLEL_LINK_JOBS=20"

if [ "$BUILDBOT_CLOBBER" != "" ]; then
  echo @@@BUILD_STEP clobber@@@
  rm -rf llvm
  rm -rf ${STAGE1_DIR}
fi

echo @@@BUILD_STEP update@@@
buildbot_update

echo @@@BUILD_STEP build@@@
build_stage1_clang

echo @@@BUILD_STEP check-llvm@@@
(cd ${STAGE1_DIR} && ninja check-llvm) || echo @@@STEP_FAILURE@@@

echo @@@BUILD_STEP check-clang@@@
(cd ${STAGE1_DIR} && ninja check-clang) || echo @@@STEP_FAILURE@@@

echo @@@BUILD_STEP check-asan@@@
(cd ${STAGE1_DIR} && ninja check-asan) || echo @@@STEP_FAILURE@@@
