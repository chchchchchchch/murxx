#!/bin/bash

  TMPDIR="/tmp"
  REMOTESRC=`echo $* | sed 's/ /\n/g' | grep -v -- "^--" | tail -n 1`
  REMOTEGET="$TMPDIR/"`basename $REMOTESRC`
# --------------------------------------------------------------------------- #
# DOWNLOAD REMOTE SRC
# --------------------------------------------------------------------------- #
  wget -q $REMOTESRC -O $REMOTEGET
# --------------------------------------------------------------------------- #
  if   [ `echo $* | sed 's/ /\n/g' | grep -- "^--tex" | wc -l` -gt 0 ]
  then    MODUS="TEX"
          if [ -f $REMOTEGET ]
          then mv $REMOTEGET $TMPDIR/tmp.zip
          else echo "SOMETHING WENT WRONG";exit 0;
          fi
  elif [ `echo $* | sed 's/ /\n/g' | grep -- "^--ttf" | wc -l` -gt 0 ]
  then    MODUS="TTF"
          if [ -f $REMOTEGET ]
          then sleep 0
          else echo "SOMETHING WENT WRONG";exit 0;
          fi
  else    echo "DON'T KNOW WHAT TO DO?"
          exit 0;
  fi
 # -------------------------------------------------------------------- #
   if [ "$MODUS" == TEX ] # ========================================= #
   then # ----------------------------------------------------------- #
        # UNZIP AND MOVE TO TEXMFHOME
        # ----------------------------------------------------------- #
          TEXMFHOME=`kpsewhich --var-value=TEXMFHOME`
          if [ ! -d "$TEXMFHOME" ];then
               echo "NO TEXMFHOME DIR"
               cd /etc/texmf/texmf.d
               touch 00_texmfhome.cnf
               echo "TEXMFHOME = ~/.TEXMF" > 00_texmfhome.cnf
               mkdir ~/.TEXMF
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
        # ----------------------------------------------------------- #
        # UPDATE TEX INSTALLATION
        # ----------------------------------------------------------- #
          UPDMAP="$TEXMFHOME/web2c/updmap.cfg"
          for MAP in `find $TEXMFHOME -name "*.map" | #
                      rev | cut -d "/" -f 1 | rev | sort -u`
           do echo "Map $MAP" >> $UPDMAP
          done
        # ----------------------------------------------------------- #
          sort -u -o $UPDMAP $UPDMAP
        # ----------------------------------------------------------- #
          updmap
        # ----------------------------------------------------------- #
   fi # ============================================================= #
 
 # -------------------------------------------------------------------- #
   if [ "$MODUS" == TTF ] # ========================================= #
   then # ----------------------------------------------------------- #
          mkdir -p ~/.fonts/murxx

          ISZIP=`echo $REMOTEGET | grep ".zip$" | wc -l`
          if [ "$ISZIP" == 1 ]
          then unzip $REMOTEGET -d ~/.fonts/murxx
          else cp $REMOTEGET ~/.fonts/murxx
          fi
        # ----------------------------------------------------------- #
   fi # ============================================================= #
 # -------------------------------------------------------------------- #

# --------------------------------------------------------------------------- #
# CLEAN UP
# --------------------------------------------------------------------------- #
  rm $REMOTEGET

exit 0;

