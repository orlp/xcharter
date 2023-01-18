# XCharter

High quality Charter TTF, OTF and WOFF2 builds.

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

I wrote a Python script that can read, combine and transform (only kerning data)
from `afm` to `feat` files. I use this script to combine the features, being
true to the original kerning where possible.

Then, using `conv_afm_feat.py`, `t1utils` from `brew`, `makeotf` and `otf2ttf` from Adobe's `afdko`,
we can build all ours files. We need the `t1utils` to convert the font files into an ASCII format
because Adobe's tools struggle with the binary format for one of the fonts.

After that I generate the webfonts from the .ttf files using fontsquirrel,
leaving everything untouched except letting it fix vertical metrics.


