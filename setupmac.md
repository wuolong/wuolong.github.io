Mac Setup
================

# SSH

To enable remote ssh login, turn on "Remote Login" in *Settings* - *Sharing*, under the *Advanced* section.

Both RSA and DSA keys are obsolete (as of October 2026). By default, the `ssh-keygen` commend generates an [Ed25519](https://ed25519.cr.yp.to) key.

To use the key to log in remote server, delete the obsolete `authorized_keys` or `authorized_keys2` files if exist. On the local machine, do the following. It will ask the password the first time but will install the pub key on the remote server and use it in the future.

```shell
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@remote.server
```

# Github Access

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
