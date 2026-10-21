New Mac Setup
================

# Settings

- Trackpad → turn off "Natural scrolling"
- Keyboard → Modifier Keys → Caps Lock Key - select "Control Key"
- Keyboard → Function Keys → turn on "Using F1, F2, etc. keys as standard function keys"
- Desktop & Dock → turn on "Automatically hide and show the dock", make the Size small, and Magnification larger.

# Terminal and Zsh

## Terminal 

There is [iTerm2](https://iterm2.com) but the built-in Terminal.app is sufficient for me. 
- Profile: "Pro" as default
- Font: SF Mono Regular
- On the 'Shell' tab → 'When the shell exits', select 'Close if the shell exited clearnly'.

## zsh

[Oh-my-zsh](https://ohmyz.sh) looks very fancy but I'll have to see if I need it.

There are several startup files:

### .zshenv

This always executed first, keep it minimal. Mine is empty.

### .zprofile

This is executed second for login shells. Set environment variables including PATH here

```shell
# neovim 
export VISUAL=nvim
export EDITOR="$VISUAL"

# homebrew - recommended method vs adding to PATH manually
eval "$(/opt/homebrew/bin/brew shellenv)"

# Some local files (aider)
export PATH=$HOME/.local/bin:$PATH
```

### .zshrc

For interactive shells:

```shell
export PROMPT='%F{146}%1~ %f%# '
export CLICOLOR=1
export LSCOLORS="gxfxcxdxbxdeedabagacad"
# lesspipe
export LESSOPEN="|lesspipe.sh %s" 
export LESS_ADVANCED_PREPROCESSOR=1

# ZSH features
# note the options are not case sensitive and _ is ignored
setopt no_case_glob             # ignore case for wildcard matching
setopt auto_cd                  # cd with directory name
setopt correct

# Alias
alias l='ls -cF'
alias la='ls -aF'
alias ll='ls -talh'
alias rm='rm -i'
alias mv='mv -i'
alias h='history'
alias vim='nvim'
alias vi='nvim'
uname -a

# no hints about environment variables
export HOMEBREW_NO_ENV_HINTS=1
```

### .zlogin

Also for login shells. I don't have it.

## Homebrew

Install [Homebrew](https://brew.sh) package manager:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## neovim

A replacement for the built-in [vim](https://www.vim.org). This is easier to install directly from [neovim.io](https://neovim.io). It's not updated frequently and homebrew always installs a bunch of dependencies. 

This does require some manual copying:
```shell
sudo cp ~/Downloads/nvim-macos-arm64/bin/nvim /usr/local/bin
sudo cp -r ~/Downloads/nvim-macos-arm64/lib/nvim /usr/local/lib 
sudo cp -r ~/Downloads/nvim-macos-arm64/share/icons /usr/local/share         
sudo cp -r ~/Downloads/nvim-macos-arm64/share/man/man1/nvim.1 /usr/local/share/man/man1 
sudo cp -r ~/Downloads/nvim-macos-arm64/share/nvim /usr/local/share 
```

MacOS blocks nvim by default, 
1. Try running nvim once so macOS records the block.
2. Open Apple menu → System Settings → Privacy & Security.
3. Scroll to Security.
4. Find the message saying nvim was blocked, then click Open Anyway.
5. Try running nvim again, and this time there is an "Open Anyway" option.
6. Authenticate with your password or Touch ID and confirm.

## lesspipe

[Lesspipe](https://github.com/wofr06/lesspipe) makes `less` more powerful. Again it's easier to install from the source, as homebrew also installs a version of Bash with it. It does come with configure scripts.

```shell
git clone https://github.com/wofr06/lesspipe.git lesspipe
cd lesspipe
./configure
sudo make install
```

## Pandoc

Pandoc converts files from one markup format into another. This can be installed easily with homebrew.

```shell
brew install pandoc
```

## LaTeX

I prefer to install a full-blood version from [MacTex](https://tug.org/mactex/mactex-download.html). Afterwards, run the "Tex Live Utility" app once awhile to update the packages. 

# Essential Apps

## Emacs

## SSH

To enable remote ssh login, turn on "Remote Login" in *Settings* - *Sharing*, under the *Advanced* section.

Both RSA and DSA keys are obsolete (as of October 2026). By default, the `ssh-keygen` commend generates an [Ed25519](https://ed25519.cr.yp.to) key.

To use the key to log in remote server, delete the obsolete `authorized_keys` or `authorized_keys2` files if exist. On the local machine, do the following. It will ask the password the first time but will install the pub key on the remote server and use it in the future.

```shell
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@remote.server
```

## Github Access

[Adding SSH public key to Github account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

Use this command to copy, and then paste into Github (under "Settings", "SSH and GPG keys", "New SSH key")
```shell
pbcopy < ~/.ssh/id_ed25519.pub
```

Test Github access
```shell
ssh -T git@github.com
```

This should return "You've successfully authenticated, but GitHub does not provide shell access."

Add this to the `~/.ssh/config` file and it should work.
```
Host github.com
    User git
    AddKeysToagent Yes
    IdentityFile ~/.ssh/id_ed25519
    UseKeychain yes
```

Check out a repository:
```shell
git clone git@github.com:username/repos.git repos
```



