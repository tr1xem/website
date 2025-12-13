+++
title = "My dev setup is better than yours"
description = "Deep insight about my dev env and workflow"
authors = [ "tr1x_em" ]
draft = false
updated = 2025-12-13T12:56:00.000

[taxonomies]
tags = [ "devlog", "dev" ]

[extra]
styles = []
accent_color = [ "orange", "hsl(184 100% 62.2%)" ]
banner = "ss3.png"
banner_pixels = false
+++
In this blog, I would be talking about my dev setup and workflow. This is <small>(little bit) </small> inspired by [Primagen's Course](https://frontendmasters.com/courses/developer-productivity-v2/).

## Dotfiles management

What are dotfiles? Well _dotfiles are hidden configuration files on Unix-based systems, such as Linux and macOS, that store settings, preferences, and configurations for various applications, tools, and the system environment._ So that means if you can transfer your dotfiles from one device to another device, your whole configuration (including themes) should stay the same.

For dotfiles management, I use [GNU Stow](https://www.gnu.org/software/stow) it just does a simple thing, it would create symlink of files to their actual directories. For example, I have stored my <mark>.config</mark> inside <mark>\~/dotfiles/config/.config</mark> <small>(dotfiles is a git repo btw)</small> what stow does is that it takes files <mark>\~/dotfiles/config/.config</mark> from there and symlinks it to their actually location i.e. <mark>\~/.config/</mark> so when ever I update a config it is always stored in <mark>\~/dotfiles</mark> which being a git repo gives me ability to back up my whole folder on GitHub.

I recommend you watching the following video if you want to learn more about stow

{{ youtube(id="NoFiYOqnC4o") }}

Here is my dotfiles repo: [Link](https://github.com/tr1xem/dotfiles)
