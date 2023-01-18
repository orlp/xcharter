import sys

afm_files = sys.argv[2:]

pairs = {}
for afm_file in afm_files:
    for line in open(afm_file):
        if not line.startswith("KPX "):
            continue

        _kpx, a, b, off = line.strip().split()
        pairs[(a, b)] = int(off)


with open(sys.argv[1], "w") as f:
    f.write("languagesystem DFLT dflt;\n")
    f.write("feature kern {\n")
    for (a, b), off in pairs.items():
        f.write(f"    position {a} {b} {off};\n")
    f.write("} kern;\n")

