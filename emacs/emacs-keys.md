Keybinding
====

# Modifier keys

Compared to Vi(m) that has two modes (Editor and Normal/Command), the "modeless" Emacs has more complicated key
bindings. They rely heavily on modifier keys that are not used in normal text editing. 

- Control (C): first thing I do on a new computer is to map the "Caps Lock" key to "Control" since this is used so
  often. 
  - On Mac, [Settings] -> [Keyboard] -> [Keyboard Shortcuts] -> [Modifier Keys].
  - On Windows, use [Microsoft PowerToys](https://learn.microsoft.com/en-us/windows/powertoys/) or customizable keyboards (e.g., Keychron V1).
- Meta (M): by default this is the "ALT" key on Windows. On Mac it's the "Option" key but I like to use "Command"
  key instead.
- Hyper (H): this existed in the original [Space-cadet keyboard](https://en.wikipedia.org/wiki/Space-cadet_keyboard). On Mac, I use the left "Option" key for this.

## MacOS

Sometimes the OS competes with Emacs for the key bindings so we want to avoid conflict. 

- Here the right Option key is reserved to enter special characters (like Option + R -> ®). 
- Mission Control uses Control plus arrow or number keys by default. I change to Control+Command instead ([Settings]
  -> [Keyboard] -> [Keyboard Shortcuts] -> [Mission Control]).
- Lastly, check [Settings] -> [Keyboard] -> [Keyboard Shortcuts] -> [Function Keys] to use function keys as F1, F2,
  etc.

```emacs-lisp
(setq ns-command-modifier 'meta                  ;; default is super
      ns-alternate-modifier 'hyper               ;; default is meta, aka ns-option-modifier
      ns-right-alternate-modifier 'none)         ;; for input special character
```

## Copy-n-Paste

In Emacs, 'killing' (cutting) means erasing text and copying it into the "kill ring".  'Yanking' (pasting)means
bringing text from the kill ring back into the buffer. The 'delete' commands on the other hand erase text but do not
save it in the kill ring.

- The "kill ring" is a list of blocks of text that were previously killed, shared by all buffers.
- The maximum number of entries in the kill ring is controlled by the variable `kill-ring-max` (default is 120).
- The actual contents of the kill ring are stored in variable `kill-ring`.

When yanking,
- `C-y` paste the last text in the kill ring
- `C-y` immediately followed by `C-y` cycles back the kill ring to previous text
- `M-y` shows the entire kill ring and allows you to choose which one to paste

| Key     | Function                                                        |
|---------|-----------------------------------------------------------------|
| M-\     | Delete space and tabs (`delete-horizontal-space`)               |
| C-x C-o | Delete all blank lines and leaving just one (delete-blank-line) |
|---------|-----------------------------------------------------------------|
| C-w     | Cut ('kill-region')                                             |
| C-k     | Cut the rest of the line ('kill-visual-line)                    |
| M-w     | Copy (kill-ring-save)                                           |
| M-d     | Kill the next word (kill-word)                                  |
| M-<DEL> | Kill one word backwards (backward-kill-word)                    |
| C-y     | Paste (cut-paste)                                               |
| M-y     | Paste (cua-paste-pop)                                           |
|---------|-----------------------------------------------------------------|
| C-<RET> | Set Rectangle (cua-set-rectangle-mark)                          |
|---------|-----------------------------------------------------------------|
| C-/     | Undo (undo)                                                     |
| C-?     | Undo the last undo, i.e., redo (undo-redo)                      |

# Reference

| Group     | Key     | Function                                                | Custom |
|-----------|---------|---------------------------------------------------------|--------|
| Basic     | M-=     | Count words (count-words-region)                        |        |
|           | H-=     | Count words of the entire buffer (count-words)          | X      |
|           | M-s o   | Shows lines match a regexp (occur)                      |        |
|-----------|---------|---------------------------------------------------------|--------|
| Bookmarks | C-x x m | Bookmark the file (bmkp-bookmark-set-confirm-overwrite) |        |
|           | C-x j j | Jump to a bookmark (bookmark-jump)                      |        |
|           | C-x r l | List/edit boomarks (bookmark-bmenu-list)                |        |
|           | C-x r b | Jump to bookmark or create a new one (consult-bookmark) |        |
|-----------|---------|---------------------------------------------------------|--------|
| URL       | C-c .   | browse-url-at-point                                     | X      |
| Dired     | C-x C-q | Edit file names directly (dired-toggle-read-only)       |        |
|           |         |                                                         |        |
