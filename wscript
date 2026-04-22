#!/usr/bin/python3
# this is a smith configuration file for Abyssinica font project

# override the default folders
DOCDIR = ['documentation', 'web']  # add 'web' to default
generated = 'generated/'

# set package name
APPNAME = 'DoulosSILCipher'

# set the font family name
FAMILY = APPNAME

#import glob

# set the default output folders
out = "results"  # default is currently buildlinux2
# OUTDIR = "installers"  # until these are defaults in smith itself we need to keep them
ZIPDIR = "releases"
TESTDIR = "tests"

getufoinfo('source/masters/' + FAMILY + '-Regular' + '.ufo')

# ftmlTest('tools/ftml-smith.xsl', fonts = ['reference/DoulosSILCipher-Regular.ttf'], addfontindex = 1, fontmode = 'collect')

designspace('source/' + FAMILY + '.designspace',
            target = "${DS:FILENAME_BASE}.ttf",
            ap = generated + '${DS:FILENAME_BASE}_ap.xml',
            version = VERSION,  # Needed to ensure dev information on version string
#            graphite = gdl('./source/glyph.gdh',
#                    master = 'source/graphite/slurs_main.gdl', 
#                    params = '-d -w2501 -w3521 -w510',
#                    depends = ['source/graphite/slurs_main.gdl', 'source/graphite/slurs_features.gdl', 'source/graphite/stddef.gdh']
#                ),
            opentype = fea(generated + '${DS:FILENAME_BASE}.fea',
                    master = 'source/opentype/main.feax', 
                    mapfile = generated + '${DS:FILENAME_BASE}.map'
                ),
            script = 'latn',
            pdf = fret(params="-r -oi"),
            woff = woff('web/${DS:FILENAME_BASE}.woff', params='-v ' + VERSION + ' -m ../source/' + FAMILY + '-WOFF-metadata.xml'),
    )
