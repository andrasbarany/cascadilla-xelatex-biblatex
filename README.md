## What is this?

This project provides a (Xe)LaTeX class aiming to implement the style sheet of
the Cascadilla Proceedings Project
(http://www.lingref.com/cpp/authors/style.html).

## Who is this for?

If you are writing a paper for proceedings published by the Cascadilla
Proceedings Project, you should be able to submit a properly typeset version
using this class. 

There is an existing LaTeX-class for Cascadilla proceedings, Max Bane's
`cascadilla.cls` (https://github.com/maxbane/cascadilla.cls).

The current class uses some more up-to-date packages, in particular
**`biblatex`** and **`biber`** instead of `bibtex`/`natbib`. `biblatex` and
`biber` are more modern than `bibtex`/`natbib` and unless you have good reasons
*against* using them, you might as well upgrade (both should be part of
a regular TeX installation these days).

Personally, I have used this class to write a paper for the proceedings of
WCCFL 2020. As of January 2021, the class provided a PDF that was accepted by
the WCCFL editors. 

However, there is no guarantee that a paper typeset using this class will be
accepted. You can contact me if you run into any trouble.

## Recent fixes

- I made sorting more reliable. The bibliography should now be sorted
  alphabetically.

## Package options

### Paper size

As you can read in `example.tex` and `example.pdf`, the package provides the
options `a4paper` (default; I'm European...) and `letter` for page sizes.
Example:

```
\documentclass[letter]{cascadilla-xelatex-biblatex.cls}
```

### Typeface

If you use XeLaTeX you can also specify `xits` (default) or `times`. The [XITS
typeface](https://github.com/alif-type/xits) is an OpenType implementation of
STIX/Times (New Roman) with Math support.

When compiling with pdfLaTeX, the `newtxtext` package is used.

### Example packages: `expex`, `gb4e`, `linguex`

By default, the class uses the `expex` package but you can use the `gb4e` or
`linguex` options to switch to those packages. See `example.pdf` for details.

## Requirements

- `biblatex` and `biber`

I've been using `biblatex`/`biber` over `bibtex`/`natbib` because the former
are being developed actively are much more straightforward to customise and
have native Unicode support. You don't have to adapt your bibliography or your
citation commands either as you can use `biblatex` in a `natbib`-compatibility
mode.

- `biblatex-unified` style

This class does not provide the bibliography styles it uses. It specifies the
use of the `biblatex-unified` style
(https://github.com/semprag/biblatex-sp-unified/). Please download the
`unified.bbx` and `unified.cbx` styles from there and follow the instructions
provided.

## Using the class

To use the class, you have several options. You can download the class file
(`cascadilla-xelatex-biblatex.cls`) and place it in your document's folder (or
your system's LaTeX folder.

I've also made the files available on
[overleaf](https://www.overleaf.com/read/wtmgnscdvwrt). You can simply copy
them into your own project and work with the existing template.

## License

See `LICENSE`.
