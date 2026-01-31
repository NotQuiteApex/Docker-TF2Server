# Team Fortress 2 (and Mods) w/ Docker
A Docker setup to streamline and easily deploy new Team Fortress 2 servers, and servers for Source Mods like TF2 Classified and Open Fortress. These servers run the 64-bit version of srcds.

# Getting Started
You will need a basic understanding of Git, Docker, and networking.

1. Clone this repository to your machine.
2. Open the `docker-compose.yml` file and make changes to configure which game server to run.
3. When ready, run `docker compose up` inside the root of the repository.
4. The container will download and update all of the necessary game files automatically. It may need a few tries to start the download proper.
5. Once finished, the server will start automatically.
6. Make sure your ports are all forwarded correctly, and you should be able to join your new server.

Any and all addons, maps, and configuration files can be found inside the `server` folder. You'll need root permissions to edit the files inside, due to limitations of the Docker steamcmd client. See the included [README.md](server/README.md) for more details.

# Advanced Setup
TODO

# License
This project's code is licensed under the MIT license, copyright Logan "NotQuiteApex" Hickok-Dickson. See [LICENSE.md](LICENSE.md) for more details.

This project pulls and uses assets belonging to multiple third-parties such as (but not limited to) Valve Software. These assets do not fall under the license described above, and are subject to any terms described by the respective license holder(s).
