Notes
=====

# Links

- [Bookmarks](./bookmarks.md)

# Notes

- [Emacs](./emacs/emacs.md):

# Github

A free account allows unlimited public and private repositories with 500 MB of storage for public repositories. There is a limit on the number of commits but that's not a problem for personal use or small projects.

Authentication using the [GitHub CLI](https://docs.github.com/en/github-cli/github-cli/quickstart): 

``` shell
brew install gh
gh auth login
```

Create a new repository with the web interface, and check it out locally,

``` shell
git clone https://github.com/username/username.github.io 
```

GitHub uses [Github Flavored Markdown](https://github.github.com/gfm/). From the `README.md`, relative links to other pages can be inserted via `[page name](filename.md)`. The Markdown files can also be edited in the browser.

There are two URLs to keep in mind, https://github.com/wuolong/wuolong.github.io shows the github repository for
editing, and https://wuolong.github.io shows the HTML files. Note that the HTML files are statically generated by
[Jekyll](https://jekyllrb.com) and changes to the Markdown files may take some time to show up in the HTML.

# Data Science

- [Julia Tutorial for Statisticians](./notes/juliar.html)
- [Statistics with Julia Workbook](./notes/statjulia.md): a Julia Markdown notebook for examples in the book [Statistics with Julia](<https://statisticswithjulia.org>).
- [Set Mac for Data Science with Emacs](mac-emacs-data.md)

