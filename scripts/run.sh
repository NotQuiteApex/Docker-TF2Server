#!/usr/bin/env bash
# Runs the server itself. Also updates the server whenever the server shuts down cleanly.

# Print statement to differentiate container messages from everything else.
p () {
    G=$'\t\e[0;32m\e[1m#### '
    C=$'\e[0m'
    echo "$G$1$C"
}

# Then we determine if the provided game is a game this image supports.
if [[ "$SERVER_GAME" == "tf2" ]]; then
    p "Team Fortress 2 server selected."
elif [[ "$SERVER_GAME" == "tf2c" ]]; then
    p "Team Fortress 2 Classified server selected."
elif [[ "$SERVER_GAME" == "of" ]]; then
    p "Open Fortress server selected."
else
    p "Unknown game server \"$SERVER_GAME\" requested."
    p "Cannot determine game server to run."
    p "Exiting..."
    exit 2
fi

# Then we start the server loop.
while : ; do
    cd /root/.steam/sv || exit 3

    p "Updating sever files..."
    # Update TF2 (always)
    until steamcmd +runscript /root/.steam/svscripts/tf2-update.txt; do
        p "Failed to update Team Fortress 2."
        p "Trying again in five seconds."
        sleep 5
    done
    mkdir /root/.steam/sv/tf2
    ln -s "/root/.steam/steam/steamapps/common/Team Fortress 2 Dedicated Server" /root/.steam/sv/tf2

    # Update Source Mod (if applicable)
    if [[ "$SERVER_GAME" == "tf2c" ]]; then
        until steamcmd +runscript /root/.steam/svscripts/tf2c-update.txt; do
            p "Failed to update Team Fortress 2 Classified."
            p "Trying again in five seconds."
            sleep 5
        done
        cd ./tf2c/bin/linux64 || exit 3
        ln -s server.so server_srv.so
        rm libvstdlib.so
        ln -s libvstdlib_srv.so libvstdlib.so
        cd ../../.. || exit 3
    elif [[ "$SERVER_GAME" == "of" ]]; then
        until steamcmd +runscript /root/.steam/svscripts/of-update.txt; do
            p "Failed to update Open Fortress."
            p "Trying again in five seconds."
            sleep 5
        done
    fi
    p "Update finished."

    p "Starting server."
	p "Using args:"
    if [[ "$SERVER_GAME" == "tf2" ]]; then
        p "\`./tf2/srcds_run_64 -console -game tf $*\`"
             ./tf2/srcds_run_64 -console -game tf "$@"
    elif [[ "$SERVER_GAME" == "tf2c" ]]; then
        p "\`./tf2c/srcds_run_64 -console -tf_path /root/.steam/sv/tf2 -game tf2classified $*\`"
             ./tf2c/srcds_run_64 -console -tf_path /root/.steam/sv/tf2 -game tf2classified "$@"
    elif [[ "$SERVER_GAME" == "of" ]]; then
        p "\`./of/srcds_run_64 -console -tf_path /root/.steam/sv/tf2 -game open_fortress $*\`"
             ./of/srcds_run_64 -console -tf_path /root/.steam/sv/tf2 -game open_fortress "$@"
    fi

	p "Server exited cleanly. Restarting..."
done
