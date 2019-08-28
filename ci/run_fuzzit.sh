#!/bin/bash -eux

# Dynamically source fuzzing targets
#declare -r FUZZER_TARGETS_CC=$(find . -name *_fuzz_test.cc)
#declare -r FUZZER_TARGETS="$(for t in ${FUZZER_TARGETS_CC}; do echo "${t:2:-3}"; done)"

FUZZ_TEST_TARGETS="$(bazel query "attr('tags','fuzzer',${TEST_TARGETS})")"
echo $FUZZ_TARGETS

#declare BAZEL_BUILD_TARGETS=""
#for t in ${FUZZER_TARGETS}
#do
#  declare BAZEL_PATH="//"$(dirname "$t")":"$(basename "$t")
#  declare TAGGED=$(bazel query "attr('tags', 'no_fuzz', ${BAZEL_PATH})")
#  if [ -z "${TAGGED}" ]
#  then
#    FILTERED_FUZZER_TARGETS+="$t "
#  fi
#done

# run fuzzing regression or upload to Fuzzit for long running fuzzing job ($1 is either local-regression or fuzzing)
wget -O fuzzit https://github.com/fuzzitdev/fuzzit/releases/download/v2.4.45/fuzzit_Linux_x86_64
chmod a+x fuzzit
#PREFIX=$(realpath "${ENVOY_DOCKER_BUILD_DIR}"/tmp/_bazel_bazel/*/execroot/envoy/bazel-out/k8-fastbuild/bin)
#find "${ENVOY_DOCKER_BUILD_DIR}" | grep _with_libfuzzer$

#find "${ENVOY_DOCKER_BUILD_DIR}" | grep _with_libfuzzer$ | grep runfiles | while read t;
#do
#  TARGET_BASE="$(expr "$t" : '.*/\(.*\)_with_libfuzzer')"
#  # Fuzzit target names can't contain underscore
#  FUZZIT_TARGET_NAME=${TARGET_BASE//_/-}
#  #if [ "${1}" == "fuzzing" ]; then
#  #  ./fuzzit create target --skip-if-exists --public-corpus envoyproxy/"${FUZZIT_TARGET_NAME}"
#  #fi
#  ls -la "${t}"
#  FUZZER_PATH=$(realpath "${t}")
#  ./fuzzit create job --skip-if-not-exists --type "${1}" envoyproxy/"${FUZZIT_TARGET_NAME}" "${FUZZER_PATH}"
#done
