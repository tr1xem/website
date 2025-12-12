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
  { name = "Telegram", url = "https://t.me/tr1xem" },
  { name = "Matrix", url = "https://matrix.to/#/@tr1xem:matrix.org" },
  { name = "Email", url = "mailto:admin@trix.is-a.dev" },
]
forges = [
#{ name = "Codeberg", url = "https://codeberg.org/trx1em" },
 { name = "GitHub", url = "https://github.com/tr1xem" },
 { name = "GitLab", url = "https://gitlab.com/trx1_em" },
]
socials = [
  { name = "Reddit", url = "https://www.reddit.com/u/l_lawliet_9999", favorite = true },
  { name = "Mastodon", url = "https://mastodon.social/@tr1x_em" },
  { name = "Bluesky", url = "https://bsky.app/profile/tr1xem.bsky.social" },
  { name = "Twitch", url = "https://www.twitch.tv/tr1x_em" },
  { name = "Twitter", url = "https://x.com/tr1x_em" },
  { name = "YouTube", url = "https://www.youtube.com/@tr1x_em" },
]





+++

<div class="container-fill">

<div>
{{ poloroid() }}

<div id="title">

tr1x_em

</div>
Greetings! Welcome to my little corner on the World Wild Web and a second home of mine. You might know me by my online handle; tr1x_em.

<div class="buttons start big">
  <a href="#about" class="suggested">About Me ↓</a>
  <a href="/blog">Blogs →</a>
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
<article class="online fancy-list">
<strong id="contacts" class="title">Contacts</strong>

For me it's currently <time id="clock">09:41</time> <small>(UTC+5:30)</small> and I'm <span id="online-indicator"><i class="icon"></i><span id="online-indicator-text">Offline</span></span>.

Feel free to reach me out on any of these! Although I'm usually active on Discord, I'm happy to talk about tech and stuff always!!!

{{ online(type="contacts") }}

</article>
</li>

</ul>

## Projects

#### Comming soon™
