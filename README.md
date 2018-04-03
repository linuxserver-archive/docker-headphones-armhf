[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://github.com/rembo10/headphones
[hub]: https://hub.docker.com/r/lsioarmhf/headphones/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# lsioarmhf/headphones
[![](https://images.microbadger.com/badges/version/lsioarmhf/headphones.svg)](https://microbadger.com/images/lsioarmhf/headphones "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/lsioarmhf/headphones.svg)](https://microbadger.com/images/lsioarmhf/headphones "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/lsioarmhf/headphones.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/lsioarmhf/headphones.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/armhf/armhf-headphones)](https://ci.linuxserver.io/job/Docker-Builders/job/armhf/job/armhf-headphones/)

Headphones is an automated music downloader for NZB and Torrent, written in Python. It supports SABnzbd, NZBget, Transmission, µTorrent and Blackhole.

[![headphones](http://i.imgur.com/5vSV3Gkl.png)][appurl]

## Usage

```
docker create \
    --name="Headphones" \
    -v /path/to/headphones/data:/config \
    -v /path/to/downloads:/downloads \
    -v /path/to/music:/music \
    -e PGID=<gid> -e PUID=<uid> \
    -e TZ=<timezone> \
    -p 8181:8181 \
    lsioarmhf/headphones
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 8181` - the port(s)
* `-v /config` - Configuration file location
* `-v /music` - Location of music. (i.e. /opt/downloads/music or /var/music)
* `-v /downloads` - Location of downloads folder
* `-e PGID` for for GroupID - see below for explanation - *optional*
* `-e PUID` for for UserID - see below for explanation - *optional*
* `-e TZ` for setting timezone information, eg Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it Headphones /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application
`IMPORTANT... THIS IS THE ARMHF VERSION`

Access WebUI at http://localhost:8181 and walk through the wizard.

## Info

* To monitor the logs of the container in realtime `docker logs -f Headphones`.

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' headphones`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' lsioarmhf/headphones`

## Versions

+ **03.04.18:** Remove forced port.
+ **05.01.18:** Rebase to alpine 3.7.
+ **20.07.17:** Internal git pull instead of at runtime.
+ **29.05.17:** Add flac package to handle FLAC based .cue., Rebase to alpine 3.6.
+ **03.05.17:** Reduce layer, replace broken source for shntool.
+ **07.02.17:** Rebase to alpine 3.5.
+ **14.10.16:** Add version layer information.
+ **11.09.16:** Add layer badges to README.
+ **08.09.16:** Inital Release
