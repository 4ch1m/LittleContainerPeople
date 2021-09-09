# Little Container People
> Activision's [Little Computer People](https://en.wikipedia.org/wiki/Little_Computer_People) inside a ([Docker](https://www.docker.com/)) container. :man_dancing: :house:

## Content

* [Concept](#concept)
* [Ingredients](#ingredients)
* [Requirements](#requirements)
* [Instructions](#instructions)
* [Customization](#customization)
* [Links](#links)

### Concept

```
               ┌────────────────────────────────────────────────────────────┐
               │ Container                                                  │
┌─────────┐    │   ┌──────────────┐    ┌────────────┐    ┌──────────────┐   │
│ Web     │    │   │ (HTML-based) │    │            │    │              │   │
│ Browser │    │   │ VNC Viewer   │    │ VNC Server │    │ C64 Emulator │   │
│       ◄─┼────┼───┼─►          ◄─┼────┼─►        ◄─┼────┼─►     ▲      │   │
└─────────┘    │   └──────────────┘    └────────────┘    └───────┼──────┘   │
               │                                                 │          │
               ├─────────────────────────────────────────────────┼──────────┤
               │                            [ LCP game binary ] ─┘          │
               └────────────────────────────────────────────────────────────┘
```

### Ingredients

* Container: [Debian](https://hub.docker.com/_/debian)
* VNC Viewer: [noVNC](https://novnc.com/)
* VNC Server: [x11vnc](https://github.com/LibVNC/x11vnc)
* C64 Emulator: [VICE](https://vice-emu.sourceforge.io/)

### Requirements

* [Docker](https://www.docker.com/) (and [docker-compose](https://docs.docker.com/compose/)) installed on your system.
* The [Little Computer People](https://en.wikipedia.org/wiki/Little_Computer_People) game binary (in disk or tape format).
* An itch for nostalgic entertainment. :joystick: 

### Instructions

* Clone this repository:  
  `git clone https://github.com/4ch1m/LittleContainerPeople.git`


* **IMPORTANT:**  
  Place your D64-binary of LCP into the cloned directory and name it `lcp.d64`.  
  (The tape version can also be used; see "[Customization](#customization)" below.)


* Execute:  
  `docker-compose up`  
  (This will build and start the container.)


* Open a web-browser and navigate to `http://localhost:8080`.


* You should see the output of VICE in your browser.  
  (Note: It may take a few seconds until VICE finished loading the disk/tape; so be patient.)


* Enjoy! :nerd_face:

### Customization

Simply create an `.env` file right next to the [docker-compose.yml](docker-compose.yml) file and set the values as needed.

* `LCP_BIN`: The file that gets auto-loaded by VICE upon container start (default: "lcp.d64").
* `LCP_PORT`: The port under which the web interface can be reached (default: "8080").
* `LCP_VICE_OPTS`: Additional [options/settings](https://vice-emu.sourceforge.io/vice_6.html) for the VICE emulator (default: "-VICIIfilter 0").

e.g.

```
LCP_BIN=lcp.t64
LCP_PORT=8181
LCP_VICE_OPTS=-speed 500
```

### Links

* Helpful information about the game: [C64 Wiki](https://www.c64-wiki.com/wiki/Little_Computer_People)
* LCP Tools from Snowdog: [CSDb](https://csdb.dk/release/?id=56264&show=notes)
* YouTube videos:  
  - [C64-Longplay](https://www.youtube.com/watch?v=LFcg8I21cng) | DerSchmu
  - [The Sims wouldn't exist without This](https://www.youtube.com/watch?v=rYz_leh9J3E) | Nostalgia Nerd
  - [The secret way every Little Computer People floppy disk was unique](https://www.youtube.com/watch?v=wZpqABBbd_I) | Retro Recipes
  - [What was Artificial Intelligence like in 1985? Ask Little Computer People!](https://www.youtube.com/watch?v=yqVlydAEKmg) | Retro Recipes
