import sys

afm_files = sys.argv[2:]

ascender = None
descender = None
capheight = None
xheight = None

pairs = {}
for afm_file in afm_files:
    for line in open(afm_file):
        if line.startswith("Ascender "):
            _, ascender = line.split()
        elif line.startswith("Descender "):
            _, descender = line.split()
        elif line.startswith("CapHeight "):
            _, capheight = line.split()
        elif line.startswith("XHeight "):
            _, xheight = line.split()
        elif line.startswith("KPX "):
            _kpx, a, b, off = line.strip().split()
            pairs[(a, b)] = int(off)



with open(sys.argv[1], "w") as f:
    f.write("languagesystem DFLT dflt;\n")
    f.write("feature kern {\n")
    for (a, b), off in pairs.items():
        f.write(f"    position {a} {b} {off};\n")
    f.write("} kern;\n")

    f.write("table hhea {\n")
    if ascender is not None:
        f.write(f"    Ascender {ascender};\n")
    if descender is not None:
        f.write(f"    Descender {descender};\n")
    f.write("} hhea;\n")
    
    f.write("table OS/2 {\n")
    if capheight is not None:
        f.write(f"    CapHeight {capheight};\n")
    if xheight is not None:
        f.write(f"    XHeight {xheight};\n")
    f.write("} OS/2;\n")

