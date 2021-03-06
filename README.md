# Notebooks

This is my collection of notes and bookmarks.

## What to do with Notes 

There are many note-taking apps from OneNote, [Evernote](https://evernote.com),
[Notability](https://www.gingerlabs.com) to simple ones like Google Keep or Apple
Notes. But they all have some serious drawbacks:

- They are not [Emacs](https://www.gnu.org/software/emacs/).
- Challenged by text formatting, either very messy or non-existent.
- Proprietary file formats, not conduit to version control.

For simple notes I use Apple Notes, which has the virtue of being always available in
every device I use. Otherwise I prefer keeping notes in plain text format and editing
with Emacs. But the latter does have the problem of not being available in mobile
devices. In addition although not a social networking fanatic, I do like to share
notes sometimes.

In the past I have used [Muse](https://www.gnu.org/software/emacs-muse/index.html),
an Emacs authoring environment for notes, and publish as HTML to the web
server. Later I switched to [Org-mode](https://orgmode.org).

Org-mode is great as an all encompassing tool for keeping notes, maintaining todos,
project planning, and integrate with Emacs Calendar. But since I use multiple devices
including mobiles and work computers, and don't always access to Emacs, it is no
longer a viable solution.

## Markdown

So lately I have been using [Markdown](https://www.markdownguide.org) for keeping
notes. There are some Markdown editors available on mobile devices,
[Bear](https://bear.app) looks very nice but I use [1Writer](https://1writerapp.com)
which does not require a subscription. The apps can access Markdown files stored on
the cloud, such as iCloud Drive or Dropbox. 

One last problem is that while these apps offer a "preview" of the notes in HTML,
they cannot share notes in HTML.

## Github Blogs

Then I found out that I can use Github to keep notes in Markdown, edit them in either
Emacs or 1Writer, and make the resulted HTML available as web pages. This is very
easy although it is surprisingly hard to find a clear instruction.

- Register a free account on Github.
- Start a new repository, name it *username.github.io* which will be the URL for the
  website. 
  - There is a choice of making the repository public or private. If the former, the
    URL is visible by the public, although only "collaborators" can edit the pages.
  - One can also pick a theme for the rendered HTML pages. 
- Select 'yes' to automatically generate a `README.md` file, which will be the
  starting webpage.
- Check out the repository to the computer. Note that as a public repository, a
password is not required to check out a repository, only when checking in.
```
% git clone https://github.com/username/username.github.io
```
- Now one can edit the Markdown files either on computer and push the edits to the
  server; or edit the files directly in a web browser. 
- There are two URLs to keep in mind, `github.com/username/username.github.io` shows
  the github repository for editing, and `username.github.io` which shows the HTML
  files. Note that the HTML files are statically generated by
  [Jekyll](https://jekyllrb.com) and changes to the Markdown files may take some time
  to show up in the HTML.
- Github uses [Github Flavored Markdown](https://github.github.com/gfm/). From the
  `README.md`, relative links to other pages can be inserted via `[page
  name](filename.md)`.
  
## Links 

- [Set Mac for Data Science with Emacs](mac-emacs-data.md)
