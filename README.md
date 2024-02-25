# enshrouded-server

# Erstelle das Image
```
docker build -t enshrouded-server:v1.0 .
```
# Starte den Docker-Container
```
docker run
  -p 15636:15636/udp \
  -p 15637:15637/udp \
  -d --name enshrouded-server-instance --restart always enshrouded-server:v1.0
```
