# XCharter

High quality XCharter TTF, OTF and WOFF2 builds.

See releases or build with `build.sh` (see below for requirements - it's a bunch).

### Process

Downloaded original bitstream charter source files from
`https://gitlab.freedesktop.org/xorg/font/bitstream-type1/-/tree/master`
to `bitstream_charter`.

```
Charter Regular = c0648bt_.afm
Charter Bold = c0632bt_.afm
Charter Italic = c0649bt_.afm
Charter Bold Italic = c0633bt_.afm
```

Downloaded the XCharter source files from `https://mirrors.ctan.org/fonts/xcharter.zip`.

I wrote a Python script that can read, combine and transform
from `afm` to `feat` files. I use this script to combine the features from XCharter
and the original font, being true to the original kerning where possible. I also
calculate the vertical metrics from the bounding boxes and set those properly.

Then, using `conv_afm_feat.py`, `t1utils` from `brew`, `makeotf` and `otf2ttf` from Adobe's `afdko`,
we can build all our files. We need the `t1utils` to convert the font files into an ASCII format
because Adobe's tools struggle with the binary format for one of the fonts. Finally using
`woff2_compress` from `brew`'s `woff2` I generate the webfonts.
