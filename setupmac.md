Mac Setup
================

# SSH

To enable remote ssh login, turn on "Remote Login" in *Settings* - *Sharing*, under the *Advanced* section.

Both RSA and DSA keys are obsolete (as of October 2026). By default, the `ssh-keygen` commend generates an [Ed29918](https://ed25519.cr.yp.to) key.

To use the key to log in remote server, delete the obsolete `authorized_keys` or `authorized_keys2` files if exist. On the local machine, do the following. It will ask the password the first time but will switch to use the key in the future.

```shell
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@remote.server
```

# Essentials

## Shell

- [Oh-my-zsh](https://ohmyz.sh)
- [iTerm2](https://iterm2.com)

## Emacs

## R

## LaTeX

## Python

# Miscellaneous

## Pandoc
