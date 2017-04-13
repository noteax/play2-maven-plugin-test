#!/bin/bash

function check() {
  stage "($2) Reset source file state"
  git checkout play24/main-project/app/service/UserServiceImpl.java

  stage "($2) Install jar dependency"
  cd play24/jar-dependency
  mvn clean install >> build.log

  stage "($2) Run play app in detached console"
  cd ../main-project
  tail -f /dev/null | `$1` >> build.log 2>&1 &

  stage "($2) Wait for 9000 port opening"
  while ! nc -z localhost 9000; do   
     sleep 0.1
  done

  stage "($2) Curl on current-user"
  userJson=$(curl -s http://localhost:9000/current-user)
  echo "Current user json is: $userJson"
  echo "$userJson" | grep admin_42 || { echo 'FAILURE: Current user role is not admin_42' ; exit 1; }

  stage "($2) Change source file and wait for 5 seconds"
  sed -i "" 's/admin_42/admin_56/g' app/service/UserServiceImpl.java
  sleep 5

  stage "($2) Curl on current-user after hot-reload"
  userJson=$(curl -s http://localhost:9000/current-user)
  echo "Current user json is: $userJson"
  echo "$userJson" | grep admin_56 || { stage "FAILURE ($2): Current user role is not admin_56" ; }
  cd ../..
}

function stage() {
 echo -en "\033[37;1;41m $1 \033[0m"
 echo
}

# install trap to kill child processes
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# check with maven
check "mvn clean play2:run" "-=maven=-"

# check with sbt
check "./sbt run" "-=sbt=-"
