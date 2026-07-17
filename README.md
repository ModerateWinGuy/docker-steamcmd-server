# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Palworld and run it.

**Server Name:** Palworld Docker  
**Password:** Docker  
**Admin Password:** adminDocker  

**Configuration:** The configuration is located at: .../Pal/Saved/Config/LinuxServer/PalWorldSettings.ini  

ATTENTION: First Startup can take very long since it downloads the gameserver files!

Update Notice: Simply restart the container if a newer version of the game is available.

You can also run multiple servers with only one SteamCMD directory!

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '2394010 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 2394010 |
| SRV_ADMIN_PWD | Your server admin password goes here | adminDocker |
| GAME_PARAMS | Enter your game parameters (for a community server put in the value '-publiclobby' without quotes) | -publiclobby -rconport=25575 |
| GAME_PARAMS_EXTRA | Enter your Extra Game Parameters seperated with a space and - (eg: -No-useperfthreads -NoAsyncLoadingThread) | -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS |
| UPDATE_PUBLIC_IP | If set to 'true' the container will check on each container start if the Public IP is still valid (the container will try to grab your public IP on the first server start since the public IP is necessary to run a community server). | false |
| BACKUP | Set this value to 'true' to enable the automated backup function from the container, you find the Backups in '.../palworld/Backups/'. Set to 'false' to disable the backup function. | true |
| BACKUP_INTERVAL | The backup interval in minutes (ATTENTION: The first backup will be triggered after the set interval in this variable after the start/restart of the container) | 120 |
| BACKUPS_TO_KEEP | Number of backups to keep (by default set to 12 to keep the last backups of the last 24 hours) | 12 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | blank |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |
| RCON_ENABLED | Enable RCON in PalWorldSettings.ini. Leave blank to keep the default | True |
| RCON_PORT | RCON port written to PalWorldSettings.ini. Leave blank to keep the default | 25575 |
| PUBLIC_PORT | PublicPort written to PalWorldSettings.ini. Leave blank to keep the default | 8211 |
| SERVER_NAME | ServerName written to PalWorldSettings.ini. Leave blank to keep the default | My Palworld Server |
| SERVER_DESCRIPTION | ServerDescription written to PalWorldSettings.ini. Leave blank to keep the default | blank |
| SERVER_PASSWORD | ServerPassword written to PalWorldSettings.ini. Leave blank to keep the default | blank |
| ALLOW_CONNECT_PLATFORM | AllowConnectPlatform written to PalWorldSettings.ini. Leave blank to keep the default | Steam |
| REST_API_ENABLED | RESTAPIEnabled written to PalWorldSettings.ini. Leave blank to keep the default | True |
| REST_API_PORT | RESTAPIPort written to PalWorldSettings.ini. Leave blank to keep the default | 8212 |
| ENABLE_NON_LOGIN_PENALTY | bEnableNonLoginPenalty written to PalWorldSettings.ini. Leave blank to keep the default | False |
| PAL_STOMACH_DECREASE_RATE | PalStomachDecreaseRate written to PalWorldSettings.ini. Leave blank to keep the default | 1 |
| PAL_EGG_DEFAULT_HATCHING_TIME | PalEggDefaultHatchingTime written to PalWorldSettings.ini. Leave blank to keep the default | 72 |
| BASE_CAMP_WORKER_MAX_NUM | BaseCampWorkerMaxNum written to PalWorldSettings.ini. Leave blank to keep the default | 15 |
| BASE_CAMP_MAX_NUM_IN_GUILD | BaseCampMaxNumInGuild written to PalWorldSettings.ini. Leave blank to keep the default | 4 |
| BUILD_OBJECT_DETERIORATION_DAMAGE_RATE | BuildObjectDeteriorationDamageRate written to PalWorldSettings.ini. Leave blank to keep the default | 1 |

Note: SRV_ADMIN_PWD is also written into PalWorldSettings.ini as AdminPassword.

## Run example
```
docker run --name Palworld -d \
	-p 8211:8211/udp -p 25575:25575 \
	--env 'GAME_ID=2394010' \
	--env 'UPDATE_PUBLIC_IP=false' \
	--env 'GAME_PARAMS=-publiclobby -rconport=25575' \
	--env 'GAME_PARAMS_EXTRA=-No-useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS' \
	--env 'BACKUP=true' \
	--env 'BACKUP_INTERVAL=120' \
	--env 'BACKUPS_TO_KEEP=12' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/palworld:/serverdata/serverfiles \
	ich777/steamcmd:palworld
```

## Docker Compose example
Copy this into a `docker-compose.yml`, fill in your own name/passwords, and run `docker compose up -d`. Only the ports and volume paths on the left of each `:` are yours to change.
```yaml
services:
  palworld:
    image: ghcr.io/moderatewinguy/palworld-steamcmd:latest
    restart: unless-stopped
    ports:
      - "8211:8211/udp"
      - "25575:25575/tcp"
      - "8212:8212/tcp"
    volumes:
      - /path/to/steamcmd:/serverdata/steamcmd
      - /path/to/palworld:/serverdata/serverfiles
    environment:
      GAME_ID: '2394010'
      UPDATE_PUBLIC_IP: 'false'
      GAME_PARAMS: -publiclobby
      GAME_PARAMS_EXTRA: -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS
      BACKUP: 'true'
      BACKUP_INTERVAL: '120'
      BACKUPS_TO_KEEP: '12'
      UID: '99'
      GID: '100'
      VALIDATE: 'true'
      SERVER_NAME: My Palworld Server
      SERVER_DESCRIPTION: A Palworld server
      SERVER_PASSWORD: changeme
      SRV_ADMIN_PWD: changeme-admin
      RCON_ENABLED: 'True'
      RCON_PORT: '25575'
      PUBLIC_PORT: '8211'
      REST_API_ENABLED: 'True'
      REST_API_PORT: '8212'
```
See the table above for the rest of the tunable `PalWorldSettings.ini` values (gameplay rates, etc.) - leave any of them out to keep the game's own default.

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/