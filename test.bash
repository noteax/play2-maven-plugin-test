#!/bin/bash

# reset all files
git reset --hard

# install jar dependency
cd play24/jar-dependency && mvn clean install

# run play app in detached console
cd ../main-project && tail -f /dev/null | mvn clean play2:run &

# wait for 9000 port opening
while ! nc -z localhost 9000; do   
  sleep 0.1
done

# curl on user-info
curl http://localhost:9000/current-user | grep admin_42

# change source file


# wait for 10 seconds

# curl on user-info once again
#curl http://localhost:9000/user-info
