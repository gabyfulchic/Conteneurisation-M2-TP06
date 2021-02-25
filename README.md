# Conteneurisation M2 TP06

## Tricks avancés dans docker-compose

Dans ce repository on peut trouver plusieurs choses : 
- 1 [docker-compose](docker-compose.yml)
* 2 Dockerfiles [ici](ssh-server/Dockerfile_server) et [ici](ssh-client/Dockerfile_client)
* 2 scripts d'entrypoint, 1 par image, [ici](ssh-client/entrypoint.sh) et [ici](ssh-server/entrypoint.sh)
* 1 fichier de configuration ssh [client](ssh-client/ssh_config) et [server](ssh-server/sshd_config)
* 1 [paire de clé](ssh/) ssh RSA-4096 partagée entre le client & le serveur

Le docker-compose lors du run va build d'abord les images locales, va lancer le sshd_server, puis le ssh client va se connecter en ssh via rsync au serveur pour récupérer un fichier/flag pour vérifier que tout fonctionne.  
Exemple d'output lorsque tout fonctionne : [stacktrace-SUCCESS](successful-stacktrace.log)

* run the project.
```bash
docker-compose up --build
```

* proof - client displaying the file he just got from the server.
![proof](commands.png)
