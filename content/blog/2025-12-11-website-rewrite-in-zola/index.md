+++
title = "Website Rewrite in Zola"
description = "The long-awaited website rewrite using the new static site generator - Zola."
authors = [ "tr1x_em" ]
updated = "2025-12-12"

[taxonomies]
tags = [ "Devlog", "Website" ]

[extra]
accent_color = [ "hsl(218.57143 7% 39%)", "hsl(192.85715 18% 70%)" ]
banner = "preview.webp"
toc = true
+++
# Backstory

Who dosent need a website? so a year ago I thought I'd create a website for myself, and I did. But guess what? it was in pure HTML and CSS (prolly from some github) repo.
But i really felt a need to have a better looking website, in which i could showcase my projects, and maybe even write a blog.

So a frnd of mine [Gasper](https://gasparvardanyan.github.io/)<small>(a very cool guy)</small> suggested me to use [Hugo](https://gohugo.io/) and i was like "wts hugo?".
I did watched a pretty good,crisp and short video on how to use it and i was like "okay, i'll give it a try".

{{youtube(id="ZFL09qhKi5I")}}

^ the goat video for hugo in my opinion.

and it turned out like this

<figure>
{{ image(url="oldweb.png", alt="Old Website", no_hover=false ,spoiler=true) }}
<figcaption>Old Website</figcaption>
</figure>

I know its shit (sometime i even surprise myself with the results 🤡), but i was like "its the most my superior brain could do". also im not at all motivated to do frontend and styling.

# Entry of Zola

I was reading [Gradience Autopsy: Rise and Set - Daudix](https://daudix.one/blog/archiving-gradience/)<small> (all love to gradience forever) </small> and the looks caught my eye. and then i got to know about [Zola](https://www.getzola.org/). Zola to me is like hugo(XD idk how correct im)
and with it i came to know about a guy named [Daudix](https://daudix.one/) and his theme for zola named [Ametrine](https://ametrine.daudix.one/) tho acc to him its not stable but as I being a arch user do not care about
stable things at all.

Ametrine is the greatest theme i have ever seen, its so simple to use and the result you are seeing it here, ofc i did copypasta from Daudix's website too but yeah thats what open source is and as someone said already

> "Original content is original only for a few seconds before getting old”<br>
> \~Rule 69 of internet

So if u you want to make a website and ur not some geeky frontend wizard, i suggest u to use zola and ametrine.

# Some Crazy Featuers and Styling

I love how it renders tables

| Page | Repo |
| --- | --- |
| Home | `pages` |
| Info | `pages` |
| Works | `pages` |
| Blog | `blog-source` |

and code blocks

```c
++
#include <iostream>

int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
```

and these github like alerts

> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.

Buttons are good too

<button class="suggested">Do Something…</button>
<a class="button external" href="https://example.org">Example</a>

and many more check it out yourself at [Ametrine's](https://ametrine.daudix.one/) website

# Conclusion

It's been an interesting journey for sure; trying to use Hugo, losing my mind, regretting life choices,
learning wierd stuff and using my 1 brain cell to think about how tf do i make it look good, burning out, coming back, learning more weird thing, procrastinating, coming back, rewriting half of the styles, and finally
finding out i had no need for it (it hurts a bit 😭). But yep i guess now this would be my main website for a long time : )

Gald i found [Ametrine](https://ametrine.daudix.one/) and [Daudix](https://daudix.one/)
