import sys
import re
import string
from collections import defaultdict

metric_files = [
    ("regular",     ["xcharter/afm/XCharter-Roman.afm",      "bitstream_charter/c0648bt_.afm"]),
    ("bold",        ["xcharter/afm/XCharter-Bold.afm",       "bitstream_charter/c0632bt_.afm"]),
    ("italic",      ["xcharter/afm/XCharter-Italic.afm",     "bitstream_charter/c0649bt_.afm"]),
    ("bold-italic", ["xcharter/afm/XCharter-BoldItalic.afm", "bitstream_charter/c0633bt_.afm"]),
]

bboxes = defaultdict(dict)
kern_pairs = defaultdict(dict)
xheights = {}
capheights = {}

re_bbox = re.compile(r"N ([^ ]+) ; B (-?\d+) (-?\d+) (-?\d+) (-?\d+) ;")
re_kernpair = re.compile(r"^KPX ([^ ]+) ([^ ]+) (-?\d+)$", re.MULTILINE)
re_capheight = re.compile(r"^CapHeight ([^ ]+)$", re.MULTILINE)
re_xheight = re.compile(r"^XHeight ([^ ]+)$", re.MULTILINE)

for style, files in metric_files:
    for filename in files:
        with open(filename) as file:
            data = file.read()
            for a, b, off in re_kernpair.findall(data):
                kern_pairs[style][(a, b)] = int(off)
            for c, llx, lly, urx, ury in re_bbox.findall(data):
                bboxes[style][c] = tuple(map(int, (llx, lly, urx, ury)))
            for capheight in re_capheight.findall(data):
                capheights[style] = int(capheight)
            for xheight in re_xheight.findall(data):
                xheights[style] = int(xheight)

# Followed advice mostly from https://github.com/googlefonts/gf-docs/tree/main/VerticalMetrics
upm = 1000
max_agrave = int(max(bboxes[style]["Agrave"][3] for style, _ in metric_files))
descender = int(max(abs(bboxes[style][c][1]) for c in string.ascii_lowercase for style, _ in metric_files))
caps_height = int(max(bboxes[style][c][3] for c in "HZ" for style, _ in metric_files))

typo_ascender = int(max(max_agrave, (1.2 * upm - caps_height) / 2 + caps_height))
typo_descender = -int(max(descender, (1.2 * upm - caps_height) / 2))
# typo_ascender = max_agrave
# typo_descender = -descender
win_ascent = max(bbox[3] for style, _ in metric_files for bbox in bboxes[style].values())
win_descent = max(abs(bbox[1]) for style, _ in metric_files for bbox in bboxes[style].values())


for style, _ in metric_files:
    with open(f"build/xcharter-{style}.feat", "w") as f:

        f.write("languagesystem DFLT dflt;\n")
        f.write("feature kern {\n")
        for (a, b), off in kern_pairs[style].items():
            f.write(f"    position {a} {b} {off};\n")
        f.write("} kern;\n")


        f.write("table OS/2 {\n")
        f.write(f"    winAscent {win_ascent};\n")
        f.write(f"    winDescent {win_descent};\n")
        f.write(f"    TypoAscender {typo_ascender};\n")
        f.write(f"    TypoDescender {typo_descender};\n")
        f.write(f"    TypoLineGap {typo_ascender};\n")
        f.write("} OS/2;\n")

        f.write("table hhea {\n")
        f.write(f"    Ascender {typo_ascender};\n")
        f.write(f"    Descender {typo_descender};\n")
        f.write(f"    LineGap {typo_ascender};\n")
        f.write("} hhea;\n")
        
