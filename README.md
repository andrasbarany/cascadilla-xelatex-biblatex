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

The current class uses some more up-to-date packages and crucially
**`biblatex`** and **`biber`** instead of `bibtex`/`natbib`. `biblatex` and
`biber` are more modern than `bibtex`/`natbib` and unless you have good reasons
*against* using them, you might as well upgrade (both should be part of
a regular TeX installation these days).

Personally, I have used this class to write a paper for the proceedings of
WCCFL 2020. As of December 2020, the class provided a PDF that was accepted by
the WCCFL editors. 

However, there is no guarantee that a paper typeset using this class will be
accepted. You can contact me if you run into any trouble.

## Package options

As you can read in `example.tex` and `example.pdf`, the package provides the
options `a4paper` (default; I'm European...) and `letter` for page sizes.
Example:

```
\documentclass[letter]{cascadilla-xelatex-biblatex.cls}
```

If you use XeLaTeX you can also specify `xits` (default) or `timesnewroman`.
The [XITS typeface](https://github.com/alif-type/xits) is an OpenType
implementation of STIX/Times (New Roman) with Math support.

When compiling with pdfLaTeX, the `newtxtext` package is used.

## Requirements

- `biblatex` and `biber`

I've been using `biblatex`/`biber` over `bibtex`/`natbib` because the former
are being developed actively are much more straightforward to customise and
have excellent Unicode support. You probably don't have to adapt your
bibliography or your citation commands either as you can use `biblatex` in
a `natbib`-compatibility mode. `biblatex` is the future (and has been for
a while).

- `biblatex-unified` style

This class does not provide the bibliography styles it uses. It specifies the
use of the `biblatex-unified` style
(https://github.com/semprag/biblatex-sp-unified/). Please download the
`unified.bbx` and `unified.cbx` styles from there and follow the instructions
provided.

## License

See `LICENSE`.
