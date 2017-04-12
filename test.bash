#!/bin/bash

# reset all files
git reset --hard

# install jar dependency
cd play24/jar-dependency
mvn clean install

# run play app in detached console
cd ../main-project
tail -f /dev/null | mvn clean play2:run &

# wait for 9000 port opening
while ! nc -z localhost 9000; do   
  sleep 0.1
done

# curl on user-info
curl -s http://localhost:9000/current-user | grep admin_42

# change source file
sed -i "" 's/admin_42/admin_56/g' app/service/UserServiceImpl.java

# wait for 10 seconds
sleep 10

# curl on user-info once again
curl -s http://localhost:9000/current-user | grep admin_56
