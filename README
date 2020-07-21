CloudFlare dynamic DNS and LetsEncrypt certificate Updater


chaosmagnetx/cloudflare-dynamic-certbot
https://github.com/Chaosmagnetx/cloudflare-dynamic-certbot
https://hub.docker.com/repository/docker/chaosmagnetx/cloudflare-dynamic-certbot


This docker will
1) Update every 15 min, your Dynamic DNS addresses at CloudFlare 
2) Using your Cloudflare authentication Issue and update (checks on startup, and daily at midnight) a LetEncrypt HTTPS certificate

Usage:

Here are some example snippets to help you get started creating a container.

docker docker create \
--name=cloudflare-dynamic-certbot \
-e email=<cloudflare email address> \
-e api=<cloudflare zone id> \
-e domain=<the.full.url.com to be updated> \
-v /path/to/certs:certs:/etc/letsencrypt \
--restart unless-stopped \
chaosmagnetx/cloudflare-dynamic-certbot

docker-compose

version: "2.1"
services:
  dcert:
    image: chaosmagnetx/cloudflare-dynamic-certbot
    restart: unless-stopped
    volumes:
      - certs:/etc/letsencrypt
    environment:
      - email=<your cloudflare login email>
      - api=<your cloudflare zone id>
      - domain=<the.full.url.com to be updated>
    container_name: dcert



Parameters
Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate external:internal respectively. For example, -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080 outside the container.

Parameter	                                            Function
-e email=your@email.com
	                    Your CloudFlare login email address
-e api=1234567898765432123456789 
                            Your cloudflare api - 'Zone ID' - can be found on the domain overview page
-e domain=the.full.url.com
                            The subdomain to be updated (must be a subdomain, or www, cannot be parent domain)
-v /etc/letsencrypt
                            The shared location or volume where the certificates are saved for use by other apps



Application Setup

Will automatically start running - can be monitored by its Log - docker logs -f dcert


Versions
20.07.20: - Initial Release.
21.07.20: - Readme, Github autobuild, comments in DockerFile
