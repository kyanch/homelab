## Build this homelab

- All important data is saved at `/srv/docker` location.
- Use `*.rpi.lan` as domain for SSL.
  - You need create your own CA cert and server certs for local area network.
  - put server certs to `<repo>/nginxproxy/certs` , make sure the name of cert files matching your domain
- You can run every service separately
  - `nginx-proxy` network should be create in advanced
- Or you can use `run.sh` to run all of them at once

Some tweaks you need to do:

1. change domain in all docker-compose files
2. edit `config.yaml` in mihomo service
3. place correct certs file in `nginxproxy/certs` if using SSL

## Use NFS at /srv/docker

Follow this wiki: [Archlinux-NFS](https://wiki.archlinux.org/title/NFS)

TL;DR

1. Add this line to your `/etc/fstab`

```text
<storage-device-ip>:<storage-device-location> /srv/docker      nfs     _netdev,noauto,x-systemd.automount,x-systemd.mount-timeout=10,timeo=14,x-systemd.idle-timeout=1min 0 0

```

2. Reload systemd daemon to take new fstab effective.

```bash
sudo systemctl daemon-reload
```

3. mount

```bash
sudo mount /srv/docker
```

Quite easy, ha.
