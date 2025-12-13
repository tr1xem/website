+++
title = "My dev setup is better than yours"
description = "Deep insight about my dev env and workflow"
authors = [ "tr1x_em" ]
draft = false

[taxonomies]
tags = [ "devlog", "dev" ]

[extra]
styles = []
accent_color = [ "orange", "hsl(184 100% 62.2%)" ]
banner = "banner.png"
banner_pixels = false
[extra.fediverse]
host = ""
user = ""
id = "115712672665196586"
+++

In this blog, I would be talking about my dev setup and workflow. This is <small>(little bit) </small> inspired by [Primagen's Course](https://frontendmasters.com/courses/developer-productivity-v2/).

TL;DR: Here is my dotfiles repo: [Link](https://github.com/tr1xem/dotfiles)

## Dotfiles management

What are dotfiles? Well _dotfiles are hidden configuration files on Unix-based systems, such as Linux and macOS, that store settings, preferences, and configurations for various applications, tools, and the system environment._ So that means if you can transfer your dotfiles from one device to another device, your whole configuration (including themes) should stay the same.

For dotfiles management, I use [GNU Stow](https://www.gnu.org/software/stow) it just does a simple thing, it would create symlink of files to their actual directories. For example, I have stored my <mark>.config</mark> inside <mark>\~/dotfiles/config/.config</mark> <small>(dotfiles is a git repo btw)</small> what stow does is that it takes files <mark>\~/dotfiles/config/.config</mark> from there and symlinks it to their actually location i.e. <mark>\~/.config/</mark> so when ever I update a config it is always stored in <mark>\~/dotfiles</mark> which being a git repo gives me ability to back up my whole folder on GitHub.

I recommend you watching the following video if you want to learn more about stow

{{ youtube(id="NoFiYOqnC4o") }}

Here is my dotfiles repo: [Link](https://github.com/tr1xem/dotfiles)

## Why use a Tilling Window Manager?

<fig>
{{ image(url="ss3.png", alt="Flux") }}
<figcaption>Flux</figcaption>
</fig>

_A desktop environment is a graphical user interface (GUI) that runs on top of an operating system, providing users with a visually intuitive way to interact with the system._

I prefer tilling window manager, Why? Because they remove the overhead of managing windows from me, and generally it's keyboard driven and as you know the more you can remove the need for a mouse the more productive and smooth your workflow gets.

I use [Hyprland](https://hypr.land/), why? Because firstly it's a tilling WM, and secondly it has awesome customization and looks <small>(I love blur btw)</small> but any tilling wm of your choice would suffice. And no I don't care about Wayland vs Xorg, I have used sway,i3,DWM in the past, and it's just I want a good-looking desktop <small>(as you can see in banner)</small>. Talking about the photo, it's my own shell that's called [Flux](https://github.com/tr1xem/flux), which is made in [Ignis](https://github.com/ignis-sh/ignis). It's just suited according to my preference, but yeah it looks good (specially the depth effect). If you are a new user, I would recommend you reading the [Hyprland's Wiki](https://wiki.hypr.land/) as it's simple and straight forward <small>(and looks good)</small>

## Tools

Now I will list down the tools I use on a daily basis.<small>(all the configs related to them are in my dotfiles repo)</small>

### Editor: Why Neovim?

<fig>
{{ image(url="neovim.png", alt="Neovim") }}
<figcaption>Neovim</figcaption>
</fig>

I personally use [Neovim](https://neovim.io/) because it's vim<small> (and vim movements)</small> and on top of it, it's highly customizable with a lot of plugins.
If you ask me, what's one thing that made my dev experience 100x better? It's learning Vim movements, and aside from the productivity parts, it actually makes the code writing an enjoyable experience. It might be a bit overwhelming to learn vim movements at first but trust me on this one it's 100% worth it. To learn, I would suggest watching this playlist [Vim as your editor](https://www.youtube.com/watch?v=X6AR2RMB5tE&list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R) by theprimagen.

### Terminal Multiplexer: Why Tmux?

<fig>
{{ image(url="tmux.png", alt="Tmux") }}
<figcaption>Tmux</figcaption>
</fig>

_A terminal multiplexer is a software application that allows multiple pseudoterminal-based login sessions to be multiplexed within a single terminal display, terminal emulator window, or remote login session._

Basically, it lets you create more than one non-volatile <small>(sessions would not stop if terminal is killed)</small>. You would be thinking, why not just use diff window? Well, yeah you can, but what if u need nine windows simultaneously? That's where tmux comes in, you can have as many shell (or windows) as you like while still being in one terminal. Another use case it like if you are ssh'd into a VPS what if u need more than one shell you have to ssh from a diff terminal window but if u use tmux only one ssh login can do it, and also it could run in background so u won't need something like screen. Also, you can split panes and do things like re-ordering and making more sessions, which made it a core part of my workflow. If you want to learn more about tmux Dreams of Code have a great [video](https://www.youtube.com/watch?v=DzNmUNvnB04) on it.

### AI Assistance: Opencode and Supermaven

<fig>
{{ image(url="opencode.png", alt="Opencode") }}
<figcaption>Opencode</figcaption>
</fig>

Personally, I don't like using AI in development side, as I don't think we are at that stage where AI could right a dependable piece of code. Neither do I like nor support the idea of <mark>Vibe Coding</mark>. But on other time like for creating a generic bash script or finding out grammatical mistakes I think [Opencode](https://opencode.ai/) is best, It's open source, the developer is super friendly, and it's not model bound that means you can use any model even bring your own local LLM.

I personally don't like the idea of AI inside your editor like one half of your editor is full of prompts and things like this, I prefer an outside of editor and terminal based agent so I could just use tmux to create a window for it. It's just my preference of keeping editor and agents different, and I guess most of the people have the same?<small>(unless they are vibe coding?)</small>

The thing I like inside my editor is AI based autocomplete, it comes in handy in most of the place. I personally use [Supermaven](https://supermaven.com/) because it's fast, free and correct<small>(most of the time)</small> and also they got a Neovim plugin that's why too.

### Terminal: Ghostty

I don't really care about it, I just use [Ghostty](https://ghostty.org/). I don't think it creates any difference, they are all the same.

### Hyprscrolling

I use Hyprscrolling to add features of a scrolling window manager to Hyprland. It's been a month since I started using it and it is great. But it totally depends on preferences, I just happen to like it.

## Container based development

Now this I learnt recently, and it's already a core part of my workflow

If you use [Systemd](https://en.wikipedia.org/wiki/Systemd) it comes with [Systemd-nspawn](https://wiki.archlinux.org/title/Systemd-nspawn) which technically creates a minimal Linux distribution (headless) which I would say is like an isolated part of your distro. It’s like the chroot command, but it is a chroot on steroids. By using containers, I can keep the host system minimal while maintaining separate, well-organized environments for different tasks. If you want to know more about this, you can refer to [Gaspar's](https://gasparvardanyan.github.io/blog/arch-workstation-3/) blog on how he manages his devlopment containers.<small>(shout out to him as he taught me this too)</small>

### Hornable mentions: Non Development tools

- [FFmpeg](https://ffmpeg.org) - the greatest tool that have ever lived
- [Tealdeer](https://github.com/tealdeer-rs/tealdeer) - Man pages are too long
- [Cppman](https://github.com/aitjcize/cppman) - All CPP man pages offline
- [Curd](https://github.com/Wraient/curd) - I use it every time I want to watch anime, truly the best.

### Conclusion

If you asked me what are the top two things you should adopt from this, I would say learning vim movements <small>(just movements, not Neovim)</small> and tmux, they alone would make a massive addition in your workflow.

If you got any suggestions or tools that you use everyday, let me know, maybe I could use them as well??

And my setup could be not better than yours <small>(or it could be)</small> but it surely is perfect for me 😉
