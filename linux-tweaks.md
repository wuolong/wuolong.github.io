# Tweaking Xubuntu on Mac

## Xubuntu

Xubuntu is [ubuntu](https://ubuntu.com) (a derivative of
[Debian](https://www.debian.org) Linux), with [Xfce](https://www.xfce.org) desktop
environment.

The Xfce Session Manager (`xfce4-session`) starts these apps:

- Window Manager (`xfwm4`)
- Desktop Manager (`xfdesktop`)
- Settings Manager (`xfce4-settings`)
- Panel (`xfce4-panel`)

## Retina Display

In **Settings Manager** (accessible from main menu **Settings**)
- **Appearance** > **Settings** > **Window Scaling** and select 2 as the
  scaling factor.  
- **Window Manager** > **Style**: select `Default-xhdpi`, also increase the
  font for window titles to 16.
- **Mouse and Keypad** > **Behavior**: increase the cursor size from the
  default of 24 to 32.

## Map CapsLock to Control

Edit `/etc/default/keyboard`and set

```
XKBOPTIONS="ctrl:swapcaps_hyper,altwin:swap_alt_win"
```

This will map the keys on mac keyboard as:

| Hardware Key   | Key    |
| -------------- | ------ | 
| *Caps Lock*    | Ctrl   |
| *Control*      | Hyper  |
| *Alt/Option*   | Super  |
| *Command*      | Meta   |


For details, check the `keyboard` man page. Note that this will only be
effective after a reboot. For this to take effect immediately, execute the
`setxkbmap` command, e.g., 

```shell
$ setxkbmap -option ctrl:nocaps
```

## Global Keyboard Shortcuts

Global shortcuts to launch applications can be set in **Settings Manager** >
**Keyboard** > **Application Shortcuts**. 

| App           | Shortcut  |
| ------------- | --------- |
| Whisker menu  | Ctrl+Esc  |
| File Manager  | Super+F   |
| App Finder    | Super+R   |
| Terminal      | Super+T   |
| Web Browser   | Super+W   |
| Emacs         | Super+3   |

The shortcuts for switching between windows can be found in **Window Manager**.

| Action                 | Shortcut  |
| ---------------------- | --------- |
| Window operations menu | Alt+Space | 
| Cycle windows          | Alt+`     |
| Show desktop           | Super+D   |

## Chrome as Default Web Browser

Download Chrome from Google and choose the Debian package and install it
with `dpkg` command. 

```shell
$ sudo dpkg -i xxxx.deb
```

When Chrome runs the first time, it will ask to set as the default and can be called
upon by the shortcut *Super+W*.
