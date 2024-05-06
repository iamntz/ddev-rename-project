setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/testrenameproject
  mkdir -p $TESTDIR
  export PROJNAME=testrenameproject
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  ddev start
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} || true
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

health_checks() {
  # Do something useful here that verifies the add-on
  # ddev exec "curl -s elasticsearch:9200" | grep "${PROJNAME}-elasticsearch"
  help_text=$(ddev help rename-project)
  [[ "${help_text}" = "Rename current project"* ]]
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev restart
  health_checks
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get iamntz/ddev-rename-project with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get iamntz/ddev-rename-project
  ddev restart
  health_checks
}