# ---------- DD ---------- #

docker build -t datetime:latest --build-arg server_port=8083 --build-arg rest_hostname=localhost --build-arg rest_port=8084 --no-cache .

docker build -t datetime:latest --build-arg server_port=8083 --build-arg rest_hostname=$(docker inspect greeting --format '{{.NetworkSettings.IPAddress}}') --build-arg rest_port=8084 .
docker stop datetime && docker rm datetime 
docker run -d -p 8083:8083 --name datetime datetime


curl http://localhost:8083/currentdatetime
curl http://localhost:8083/currentdatetime/greeting


docker logs -f datetime
docker exec -it datetime sh 
apk add curl 


git add .
git commit -m "Corrected rest_hostname"
git push

# ---------- DD ---------- #

# Access Logs https://github.com/jochenchrist/spring-boot-access-logs-demo/tree/master/src
