rm -rf dist
rm -rf build
mkdir -p dist
mkdir -p build

python3 conv_afm_feat.py build/xcharter-regular.feat     xcharter/afm/XCharter-Roman.afm      bitstream_charter/c0648bt_.afm
python3 conv_afm_feat.py build/xcharter-bold.feat        xcharter/afm/XCharter-Bold.afm       bitstream_charter/c0632bt_.afm
python3 conv_afm_feat.py build/xcharter-italic.feat      xcharter/afm/XCharter-Italic.afm     bitstream_charter/c0649bt_.afm
python3 conv_afm_feat.py build/xcharter-bold-italic.feat xcharter/afm/XCharter-BoldItalic.afm bitstream_charter/c0633bt_.afm


t1ascii xcharter/type1/XCharter-Roman.pfb       build/xcharter-regular.pfa      
t1ascii xcharter/type1/XCharter-Bold.pfb        build/xcharter-bold.pfa       
t1ascii xcharter/type1/XCharter-Italic.pfb      build/xcharter-italic.pfa     
t1ascii xcharter/type1/XCharter-BoldItalic.pfb  build/xcharter-bold-italic.pfa

makeotf -r       -f build/xcharter-regular.pfa     -ff build/xcharter-regular.feat     -o dist/xcharter-regular.otf
makeotf -r -b    -f build/xcharter-bold.pfa        -ff build/xcharter-bold.feat        -o dist/xcharter-bold.otf
makeotf -r -i    -f build/xcharter-italic.pfa      -ff build/xcharter-italic.feat      -o dist/xcharter-italic.otf
makeotf -r -b -i -f build/xcharter-bold-italic.pfa -ff build/xcharter-bold-italic.feat -o dist/xcharter-bold-italic.otf

otf2ttf dist/xcharter-regular.otf     dist/xcharter-regular.ttf      
otf2ttf dist/xcharter-bold.otf        dist/xcharter-bold.ttf         
otf2ttf dist/xcharter-italic.otf      dist/xcharter-italic.ttf       
otf2ttf dist/xcharter-bold-italic.otf dist/xcharter-bold-italic.ttf  

mkdir -p dist/ttf
mkdir -p dist/otf
mv dist/*.ttf dist/ttf
mv dist/*.otf dist/otf
