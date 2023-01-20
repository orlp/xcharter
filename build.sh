rm -rf dist
rm -rf build
mkdir -p dist
mkdir -p build

python3 conv_afm_feat.py

t1ascii xcharter/type1/XCharter-Roman.pfb       build/xcharter-regular.pfa      
t1ascii xcharter/type1/XCharter-Bold.pfb        build/xcharter-bold.pfa       
t1ascii xcharter/type1/XCharter-Italic.pfb      build/xcharter-italic.pfa     
t1ascii xcharter/type1/XCharter-BoldItalic.pfb  build/xcharter-bold-italic.pfa

makeotf  -osbOn 7 -osbOff 8 -osbOff 9 -r       -f build/xcharter-regular.pfa     -ff build/xcharter-regular.feat     -o dist/xcharter-regular.otf
makeotf  -osbOn 7 -osbOff 8 -osbOff 9 -r -b    -f build/xcharter-bold.pfa        -ff build/xcharter-bold.feat        -o dist/xcharter-bold.otf
makeotf  -osbOn 7 -osbOff 8 -osbOff 9 -r -i    -f build/xcharter-italic.pfa      -ff build/xcharter-italic.feat      -o dist/xcharter-italic.otf
makeotf  -osbOn 7 -osbOff 8 -osbOff 9 -r -b -i -f build/xcharter-bold-italic.pfa -ff build/xcharter-bold-italic.feat -o dist/xcharter-bold-italic.otf

otf2ttf dist/xcharter-regular.otf     dist/xcharter-regular.ttf      
otf2ttf dist/xcharter-bold.otf        dist/xcharter-bold.ttf         
otf2ttf dist/xcharter-italic.otf      dist/xcharter-italic.ttf       
otf2ttf dist/xcharter-bold-italic.otf dist/xcharter-bold-italic.ttf  

# ttfautohint dist/xcharter-regular.ttf     dist/xcharter-regular-hinted.ttf
# ttfautohint dist/xcharter-bold.ttf        dist/xcharter-bold-hinted.ttf
# ttfautohint dist/xcharter-italic.ttf      dist/xcharter-italic-hinted.ttf
# ttfautohint dist/xcharter-bold-italic.ttf dist/xcharter-bold-italic-hinted.ttf
# mv dist/xcharter-regular-hinted.ttf     dist/xcharter-regular.ttf     
# mv dist/xcharter-bold-hinted.ttf        dist/xcharter-bold.ttf        
# mv dist/xcharter-italic-hinted.ttf      dist/xcharter-italic.ttf      
# mv dist/xcharter-bold-italic-hinted.ttf dist/xcharter-bold-italic.ttf 

woff2_compress dist/xcharter-regular.ttf       
woff2_compress dist/xcharter-bold.ttf          
woff2_compress dist/xcharter-italic.ttf        
woff2_compress dist/xcharter-bold-italic.ttf   

mkdir -p dist/otf
mkdir -p dist/ttf
mkdir -p dist/woff2
mv dist/*.otf dist/otf
mv dist/*.ttf dist/ttf
mv dist/*.woff2 dist/woff2
