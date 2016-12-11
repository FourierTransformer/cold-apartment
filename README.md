# Cold Apartment
I really want to know just how cold my apartment is and maybe control it a bit.

## Setting up the Webapp
0. Clone this repo

    `git clone https://github.com/FourierTransformer/cold-apartment.git`


1. Make a copy the config file

    `cp config.lua.example config.lua`


2. Change `my_secret` in config.lua into something secret that only you and your raspberry pi know

3. Build the docker image
    
    `docker build -t cold-apartment .`


4. Run the production docker image

    `docker run -d -p 80:80 -p 443:443 --restart=unless-stopped cold-apartment production` (assuming you're running in prod)