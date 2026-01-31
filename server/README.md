# About this folder...
Whenever you run `docker compose up` the Docker container will download the dedicated server files for TF2 and other Source Mods here. Here you can add, modify, or remove any maps or configuration files for your server, and the changes will take effect next time you boot the server. Deleting any files here will delete them off the container!

Files in here are owned by the root user, due to issues with the Docker steamcmd client. You will need root or sudo permissions to edit the files, which you likely have anyway due to using Docker.
