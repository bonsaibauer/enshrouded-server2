# enshrouded-server

# Erstelle das Image
```
docker build -t enshrouded-server:v1.0 .
```
# Starte den Docker-Container
```
docker run -p 15636:15636/udp \
  -p 15637:15637/udp \
  -v /var/www/gameserver/enshrouded-server/savegame:/savegame \
  -d --name enshrouded-server-instance --restart always enshrouded-server:v1.0
```
```
sudo chown -R 1000:1000 /var/www/gameserver/enshrouded-server/savegame
sudo chmod -R 775 /var/www/gameserver/enshrouded-server/savegame
```
# Docker Neustart um 4 Uhr in der Nacht (Performance)
```
sudo timedatectl set-timezone Europe/Berlin
```
```
crontab -e
```
## Füge ein:
```
0 4 * * * /usr/bin/docker restart enshrouded-server-instance
```
