181008_dev:
	./lib/mdsh/mk.sh E/181008_dev.mdsh pdf

190121_dev:
	./lib/mdsh/mk.sh E/190121_dev.mdsh pdf

lokal:
	./utils/lokalize.sh --non-interactive


font-junicode:
	./utils/installfonts.sh --tex https://fontain.org/junicode/export/tex/junicode.tex.zip
font-bangers:
	./utils/installfonts.sh --ttf https://github.com/google/fonts/raw/master/ofl/bangers/Bangers-Regular.ttf
font-iaduospace:
	./utils/installfonts.sh --tex https://fontain.org/iaduospace/export/tex/ia-writer-duospace.tex.zip
	./utils/installfonts.sh --ttf https://fontain.org/iaduospace/export/ttf/ia-writer-duospace.ttf.zip
font-worksans:
	./utils/installfonts.sh --ttf https://www.fontsquirrel.com/fonts/download/work-sans.zip
font-plexmono:
	./utils/installfonts.sh --tex https://fontain.org/plexmono/export/tex/ibm-plex-mono.tex.zip
	./utils/installfonts.sh --ttf https://fontain.org/plexmono/export/ttf/ibm-plex-mono.ttf.zip 

pdf: lokal font-junicode font-bangers 181008_dev

