# netcore-docker-teamcity-script
Installer shell script for debian for:
docker
.net core 3.1
team city build agent

takes 2 parameters, team city build agent zip , team city server uri


# run via
curl https://raw.githubusercontent.com/onemustpersist/netcore-docker-teamcity-script/master/install.sh >> install.sh | chmod +x install.sh

sh install.sh "https://example.com/buildAgent.zip" "https://example.com"
