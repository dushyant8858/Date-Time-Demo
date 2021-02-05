# ---------- DD ---------- #

docker build -t datetime:latest --build-arg server_port=8083 --build-arg rest_hostname=greeting --build-arg rest_port=8084 --no-cache .
docker stop datetime && docker rm datetime 
docker run -d -p 8084:8083 --name datetime datetime
curl localhost:8084/currentdatetime


docker logs datetime
docker exec -it datetime sh 
apk add curl 


git add .
git commit -m "Added test line in Dockerfile"
git push

# ---------- DD ---------- #