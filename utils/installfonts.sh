#!/bin/bash

  REMOTEZIP="https://fontain.org/junicode/export/tex/junicode.tex.zip"
  TMPDIR="/tmp"
# --------------------------------------------------------------------------- #
# DOWNLOAD ZIP FILE
# --------------------------------------------------------------------------- #
  wget $REMOTEZIP -O $TMPDIR/tmp.zip

# --------------------------------------------------------------------------- #
# UNZIP AND MOVE TO TEXMFHOME
# --------------------------------------------------------------------------- #
  TEXMFHOME=`kpsewhich --var-value=TEXMFHOME`
  TEXMFHOME="adsd"
  if [ ! -d "$TEXMFHOME" ];then
       echo "NO TEXMFHOME DIR"
       cd /etc/texmf/texmf.d
       touch 00_texmfhome.cnf
       echo "TEXMFHOME = ~/.TEXMF" > 00_texmfhome.cnf
       mkdir /root/.TEXMF
       update-texmf
       TEXMFHOME=`kpsexpand \\$TEXMFHOME`
       cd -
  fi

  if [ -f $TMPDIR/tmp.zip ];then
       unzip -u -C $TMPDIR/tmp.zip "*.zip" -d $TMPDIR
       rm $TMPDIR/tmp.zip
       unzip -u -C $TMPDIR/*.zip "TEXMF/*" -d $TMPDIR
       cp -rp ${TMPDIR}/TEXMF/* $TEXMFHOME
  fi

# --------------------------------------------------------------------------- #
# UPDATE TEX INSTALLATION
# --------------------------------------------------------------------------- #
  UPDMAP="$TEXMFHOME/web2c/updmap.cfg"
  for MAP in `find $TEXMFHOME -name "*.map" | #
              rev | cut -d "/" -f 1 | rev | sort -u`
   do echo "Map $MAP" >> $UPDMAP
  done
# --------------------------------------------------------------------------- #
  sort -u -o $UPDMAP $UPDMAP
# --------------------------------------------------------------------------- #
  updmap
# --------------------------------------------------------------------------- #
# CLEAN UP
# --------------------------------------------------------------------------- #
  rm $TMPDIR/*.zip

exit 0;

