+++
title = "Home"
description = "The central hub."
[extra]
no_header = true
styles = ["home/style.css"]
scripts = ["home/script.js"]
anilist = "tr1xem"
contacts = [
  { name = "Discord", url = "https://discord.com/users/885063317079592961", favorite = true },
  { name = "Telegram", url = "https://t.me/tr1x_em" },
  { name = "Matrix", url = "https://matrix.to/#/@tr1xem:matrix.org" },
  { name = "Email", url = "mailto:admin@trix.is-a.dev" },
]
forges = [
#{ name = "Codeberg", url = "https://codeberg.org/tr1xem" },
 { name = "GitHub", url = "https://github.com/tr1xem" },
 { name = "GitLab", url = "https://gitlab.com/tr1x_em" },
]
socials = [
  { name = "Reddit", url = "https://www.reddit.com/u/l_lawliet_9999", favorite = true },
  { name = "Mastodon", url = "https://mastodon.social/@tr1x_em",favorite = true },
  { name = "Bluesky", url = "https://bsky.app/profile/tr1xem.bsky.social" },
  { name = "Twitch", url = "https://www.twitch.tv/tr1x_em" },
  { name = "Twitter", url = "https://x.com/tr1x_em" },
  { name = "YouTube", url = "https://www.youtube.com/@tr1x_em" },
]
graphics = [
	{ name = "4-by-3", text = "1024x768" },
	{ name = "no-js", text = "No Essential\nJavaScript" },
	{ name = "web-14", text = "14+", url = "https://www.mabsland.com/Adoption.html" },
	{ name = "profanity", text = "Mild Profanity" },
]
badges = [
 { name = "blue-team.gif", url = "https://512kb.club" },
 { name = "green-team.gif", url = "https://512kb.club" },
 { name = "orange-team.gif", url = "https://512kb.club" },
 { name = "dark-mode.gif", url = "https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme" },
 { name = "mobilefriendly.gif", url = "https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/CSS_layout/Responsive_Design" },
 { name = "righttorepair.gif", url = "https://www.ifixit.com/Right-to-Repair" },
 { name = "saynotoweb3.gif", url = "https://yesterweb.org/no-to-web3/" },
 { name = "linux.png", url = "https://kernel.org" },
 { name = "neovim.png", url = "https://neovim.io" },
 { name = "daudix.gif", url = "https://daudix.one" },
 { name = "bestviewed16bit.gif" },
 { name = "bring-back-the-headphone-jack.gif" },
 { name = "firefox3.gif", url = "https://getfirefox.com" },
 { name = "sourcemissing.gif" },
 { name = "valid-crashout.gif"},
 { name = "valid-atom.gif", url = "https://validator.w3.org/feed/" },
 { name = "nofuckingthanks.gif" },
 { name = "savewalterwhite.gif", url = "http://www.savewalterwhite.com" },
 { name = "statuscafe.gif", url = "https://status.cafe" },
 { name = "ddg.gif", url = "https://duckduckgo.com" },
 { name = "iso.gif", url = "https://www.w3.org/QA/Tips/iso-date" },
 { name = "sourcemissing.gif" },
 { name = "georgemoody.gif"},
 { name = "neo-fedi.gif" ,url="https://jointhefediverse.net" },
 { name = "smoke.gif" },
 { name = "yarrr.gif" },
 { name = "ffmpeg.png", url = "https://ffmpeg.org" },
 { name = "ublock-origin.webp", url = "https://github.com/gorhill/uBlock"},
]

+++

<div class="container-fill">

<div>
{{ poloroid() }}

<div id="title">

# tr1x_em

</div>
Greetings! Welcome to my little corner on the World Wild Web and a second home of mine. You might know me by my online handle; tr1x_em.

<div class="buttons start big">
  <a href="#about" class="suggested">About Me ↓</a>
  <a href="#splash">Splash →</a>
</div>
</div>
</div>

## About

Thing I love and hate doing the most. <small>(why writing a about section so tough for me?)</small>

<ul class="masonry">

<!-- Card Start -->
<li>
<article>

**I originate from India,** currently residing in <abbr id="hill" title="If you know, you know">mountain valley</abbr>. That means that I'm a native hindi speaker, कर भला तो हो भला।

</article>
</li>
<!-- Card End -->

<!-- Card Start -->
<li>
<article class="fancy-list">

**Random things I like:**

- Cyan <small>(its just peaceful)</small>
- Tokyonight <small>(the best the theme ngl)</small>
- Photography and editing <small>(amature)</small>
- Neovim <small>(the superior text editor)</small>
- Souls like game <small>(cuz they are tough?)</small>
- Meeting with new people :>
- Anime <small>([Anilist](https://anilist.co/user/tr1xem/))</small>
- Rasgulla <small>([Wikipedia](https://en.wikipedia.org/wiki/Rasgulla))</small>

</article>
</li>
<!-- Card End -->

<!-- Card Start -->
<li>
<article>

> "Only wimps use tape backup. REAL men just upload their important stuff on ftp and let the rest of the world mirror it."
> _~Linus_ _Torvalds_

</article>
</li>
<!-- Card End -->
<li>
<article class="fancy-list">

**I am {{ age() }} moons old.**

Back in ’06 I was still buffering… cosmic Wi-Fi was terrible

</article>
</li>

<li>
<article class="anime fancy-list">

**Anime I'm currently watching:**

{{ anime() }}

</article>

<article class="anime fancy-list">

**All time favorites:**

{{ anime_top() }}

</article>

</li>

</ul>

## Online

Where and when to find me online.

<ul class="masonry">
<li>
<article>

{{ now_playing() }}

</article>
</li>

<li>
<article class="online fancy-list">
<strong id="socials" class="title">Socials</strong>

{{ online(type="socials") }}

</article>
</li>

<li>

<article class="online fancy-list">
<strong id="forges" class="title">Forges</strong>

{{ online(type="forges") }}

</article>
</li>
<li>
<article class="linux-bunker fancy-list">
<strong id="linux-bunker" class="title">Linux Bunker</strong>

Cool place for linux nerds to chat,share and learn.

<img src="/home/linuxbunker.png" class="" />
<a href="https://discord.gg/tRFxkbQ3Zq" title="Join Server"></a>
<div>
{{ icon(name="discord-logo") }}
</div>
</article>
</li>

<li>
<article class="online fancy-list">
<strong id="contacts" class="title">Contacts</strong>

For me it's currently <time id="clock">09:41</time> <small>(UTC+5:30)</small> and I'm <span id="online-indicator"><i class="icon"></i><span id="online-indicator-text">Offline</span></span>.

Feel free to reach me out on any of these! Although I'm usually active on Discord, I'm happy to talk about tech and stuff always!!!

{{ online(type="contacts") }}

</article>
</li>

<li>
<article class="ntfy fancy-list">
<strong id="ntfy" class="title">Send Me a Notification</strong>

The moment you press "Send" I'll get a push notification. Crazy, right?

<div>
  <input id="ntfy-input" placeholder="Stolen from daudix.one"></input>
  <button id="ntfy-send" class="suggested" title="Send">
    {{ icon(name="paper-plane-right") }}
    {{ icon(name="check") }}
  </button>
</div>
<div class="tooltip" title="Powered by ntfy.sh. Messages are not end-to-end encrypted and are public. This is not a secure method of communication">
  {{ icon(name="lock-open") }}
</div>
</article>
</li>

</ul>

## IndieWeb

Simply put, IndieWeb is anything on the web that is hand-crafted, feels personal and gives a retro feel.

Everything about it is awesome, from 88x31 buttons to webrings. It also feels cozy and is hella fun, quite refreshing after the sterile corporate web.

{{ badges() }}

## Projects

#### Comming soon™
