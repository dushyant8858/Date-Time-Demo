# ---------- DD ---------- #

docker build -t datetime:latest --build-arg server_port=8083 --build-arg rest_hostname=greeting --build-arg rest_port=8084 --no-cache .
docker stop datetime && docker rm datetime 
docker run -d -p 8083:8083 --name datetime datetime


curl http://localhost:8083/currentdatetime
curl http://localhost:8083/currentdatetime/greeting


docker logs datetime
docker exec -it datetime sh 
apk add curl 


git add .
git commit -m "Enabled accesslog and tomcat/catalina=DEBUG  "
git push

# ---------- DD ---------- #