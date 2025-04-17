Emacs Lisp
=====

# Basics

## Quote and Sharp Quote

`'` is a short-hand for `quote` which is a *special form* that returns an object without evaluating it. Note that the
difference with using `list` is the latter create a mutable list)

```emacs-lisp
'(1 2 3)
(quote (1 2 3))
(setq a (list 1 2 3))
(eval 'a)
(setq print-exp (list 'print (current-buffer)))
```

A sharp-quote (`#'`), a short-hand for `function`, indicates its argument is a function. It gives the byte-compiler a hint to check for undefined functions. In practice, it behaves the same as just using quote only. 

```emacs-lisp
(mapcar #'sin '(1 2 3))
(mapcar 'sin '(1 2 3))
(mapcar (function sin) '(1 2 3))
(mapcar (function sin) (quote (1 2 3)))
```

But it is not needed for lambda expression because `lambda` is in fact a macro that expands to include `function`. The
following all work.

```emacs-lisp
(mapcar (lambda (x) (* x x)) '(1 2 3))
(mapcar (function (lambda (x) (* x x))) '(1 2 3))
(mapcar #'(lambda (x) (* x x)) '(1 2 3))
```

# Regular Expression

## Special Characters

| Meaning                 | Perl  | Emacs | Vim      |
|-------------------------|-------|-------|----------|
| grouping                | ( )   | ( )   | ( )      |
| character set           | \[ \] | \[ \] | \[ \]    |
| alternative             |       |       | `&#124;` |
| match zero or once      | ?     | ?     | ?        |
| match one or more times | \+    | \+    | \+       |
| begging of string       |       | \`    |          |
| end of string           |       | '     |          |

- `\|` is `\|`
- In emacs-lisp, the regular expression is represented by a string (using double quote `"`), however `\` itself is the
  escape character for strings hence the need to write `"\\(Aa\\|Bb\\)"` for what would be `(Aa|Bb)` in Perl and
  `"\\\\"` for a literal `\`.

## Emacs Specific

`\sC` : match matches any character whose syntax is `C`. Here `C` is a character that designates a particular syntax
class: thus, `w` for word constituent, `-` for whitespace, `.` for ordinary punctuation, etc.

# Reference

- Chassell (2021) [An Introduction to Programming in Emacs Lisp](https://www.gnu.org/software/emacs/manual/pdf/eintr.pdf) - also available in \[<info::einfo>\]
