181008_dev:
	./lib/mdsh/mk.sh E/181008_dev.mdsh pdf

lokal:
	./utils/lokalize.sh --non-interactive

junicode:
	./utils/installfonts.sh https://fontain.org/junicode/export/tex/junicode.tex.zip
