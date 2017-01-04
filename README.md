# Cold Apartment
I really want to know just how cold my apartment is and maybe one day control it a bit.

## Devices & Flow
I have a [Bean+](https://punchthrough.com/bean) that talks to a [Raspberry Pi 3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/) via [node-red](https://nodered.org/). node-red sends an HTTP POST request to this webserver, which displays the temperature, whenever it changes in my apartment. I do hope to one day have this integrate with [IFTTT](https://ifttt.com/) and a [Belkin WeMo Switch](https://ifttt.com/wemo_switch) to turn on a fan to circulate my radiator heat - we'll see how that goes!

## Server Setup
0. Install [Docker](https://docs.docker.com/engine/installation/)
1. Setup LetsEncrypt [certbot](https://certbot.eff.org/)
2. Get some certs (my server called certbot letsencrypt, so that is shown here)

    `sudo letsencrypt certonly --standalone -d ismyapartmentcold.com -d www.ismyapartmentcold.com`


3. Generate a 4096 [dhparam](http://security.stackexchange.com/questions/94390/whats-the-purpose-of-dh-parameters) file. Note: This takes forever.
    
    `sudo openssl dhparam -out /etc/letsencrypt/live/ismyapartmentcold.com/dhparam.pem 4096`


## Setting up the Webapp
0. Clone this repo

    `git clone https://github.com/FourierTransformer/cold-apartment.git`


1. Make a copy the config file

    `cp config.lua.example config.lua`


2. Change `my_secret` in config.lua into something secret that only you and your Raspberry Pi know

3. Build the docker image (i may offer a pre-built version one day)
    
    `docker build -t cold-apartment .`


4. Run the production docker image

    `docker run -d -p 80:80 -p 443:443 -v /etc/letsencrypt:/etc/letsencrypt --restart=unless-stopped cold-apartment production` (assuming you're running in prod).
