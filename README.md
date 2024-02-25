# enshrouded-server

# Erstelle das Image
'''
docker build -t enshrouded-server:v1.0 .
'''

# Starte den Docker-Container
'''
docker run --publish 15636:15636/udp \
  --publish 15637:15637/udp \
  -d --name enshrouded-server-instance enshrouded-server:v1.0
'''
