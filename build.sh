rm -rf dist
rm -rf build
mkdir -p dist
mkdir -p build

python3 conv_afm_feat.py build/charter-regular.feat     xcharter/afm/XCharter-Roman.afm      bitstream_charter/c0648bt_.afm
python3 conv_afm_feat.py build/charter-bold.feat        xcharter/afm/XCharter-Bold.afm       bitstream_charter/c0632bt_.afm
python3 conv_afm_feat.py build/charter-italic.feat      xcharter/afm/XCharter-Italic.afm     bitstream_charter/c0649bt_.afm
python3 conv_afm_feat.py build/charter-bold-italic.feat xcharter/afm/XCharter-BoldItalic.afm bitstream_charter/c0633bt_.afm


t1ascii xcharter/type1/XCharter-Roman.pfb       build/xcharter-regular.pfa      
t1ascii xcharter/type1/XCharter-Bold.pfb        build/xcharter-bold.pfa       
t1ascii xcharter/type1/XCharter-Italic.pfb      build/xcharter-italic.pfa     
t1ascii xcharter/type1/XCharter-BoldItalic.pfb  build/xcharter-bold-italic.pfa

makeotf -r       -f build/xcharter-regular.pfa     -ff build/charter-regular.feat     -o dist/charter-regular.otf
makeotf -r -b    -f build/xcharter-bold.pfa        -ff build/charter-bold.feat        -o dist/charter-bold.otf
makeotf -r -i    -f build/xcharter-italic.pfa      -ff build/charter-italic.feat      -o dist/charter-italic.otf
makeotf -r -b -i -f build/xcharter-bold-italic.pfa -ff build/charter-bold-italic.feat -o dist/charter-bold-italic.otf

otf2ttf dist/charter-regular.otf     dist/charter-regular.ttf      
otf2ttf dist/charter-bold.otf        dist/charter-bold.ttf         
otf2ttf dist/charter-italic.otf      dist/charter-italic.ttf       
otf2ttf dist/charter-bold-italic.otf dist/charter-bold-italic.ttf  

mkdir -p dist/ttf
mkdir -p dist/otf
mkdir -p dist/woff2-otf
mkdir -p dist/woff2-ttf

woff2_compress dist/charter-regular.otf
woff2_compress dist/charter-bold.otf
woff2_compress dist/charter-italic.otf
woff2_compress dist/charter-bold-italic.otf
mv dist/*.woff2 dist/woff2-otf

woff2_compress dist/charter-regular.ttf
woff2_compress dist/charter-bold.ttf
woff2_compress dist/charter-italic.ttf
woff2_compress dist/charter-bold-italic.ttf
mv dist/*.woff2 dist/woff2-ttf

mv dist/*.ttf dist/ttf
mv dist/*.otf dist/otf
