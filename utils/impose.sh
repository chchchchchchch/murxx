#!/bin/bash

 PDF="$1"
 CROPSUM="17" # 6MM IN PTS
 TMPDIR="."

 if [ ! -f $PDF ] || 
    [ `echo $PDF | grep ".pdf$" | wc -l ` -lt 1 ]
 then  echo 'GIVE ME A PDF FILE. PLEASE!'
       exit 0;
 fi
 
 PDFNAME=`basename $PDF   | #
          sed 's/\.pdf$//'` #
 TMP="$TMPDIR/${PDFNAME}_PRINT"
 WXH=`pdfinfo $PDF       | #
      grep "^Page size:" | #
      cut -d ":" -f 2    | #
      sed 's/ //g'       | #
      sed 's/x/ /g'      | #
      sed 's/[a-z]//g'`    #
 W=`echo $WXH | cut -d " " -f 1`
 H=`echo $WXH | cut -d " " -f 2`
 W=`expr $W \* 2 - $CROPSUM`
 H=`expr $H      - $CROPSUM`

 NUMPAGES=`pdfinfo $PDF      | #
           grep "^Pages"     | #
           sed 's/[^0-9]*//g'` #
 PA=$NUMPAGES
 PB="1";PC="2"
 PD=`expr $NUMPAGES - 1`

 while [ $PC -le `expr $NUMPAGES / 2` ]
  do
     PA=`echo "  $PA " | rev | cut -c 1-4 | rev`
     PB=`echo "  $PB " | rev | cut -c 1-4 | rev`
     PC=`echo "  $PC " | rev | cut -c 1-4 | rev`
     PD=`echo "  $PD " | rev | cut -c 1-4 | rev`

     # echo   "  ----- -----                 "
     # echo   " |     |     |   ----- -----  "
     # echo   " | $PA| $PB|  |     |     | "
     # echo   " |     |     |  | $PC| $PD| "
     # echo   "  ----- -----   |     |     | "
     # echo   "                 ----- -----  "

     PAGES="${PAGES},${PA},${PB},${PC},${PD}"


     PA=`expr $PA - 2`;PB=`expr $PB + 2`
     PC=`expr $PC + 2`;PD=`expr $PD - 2`

 done

 PAGES=`echo $PAGES  | #
        sed 's/^,//' | #
        sed 's/ //g'`  #

 for F in PLAIN WITHCROPMARKS
  do
     echo "\documentclass{article}"          >  ${TMP}.tex
     echo "\usepackage{xcolor}"              >> ${TMP}.tex
     echo "\usepackage{pdfpages}"            >> ${TMP}.tex
     echo "\usepackage{geometry}"            >> ${TMP}.tex
     echo "\geometry{paperwidth=${W}pt,"     >> ${TMP}.tex
     echo "          paperheight=${H}pt}"    >> ${TMP}.tex

     if [ "$F" == "WITHCROPMARKS" ]
     then   

     echo "\definecolor{cropblack}{cmyk}"    >> ${TMP}.tex  
     echo "                       {1,1,1,1}" >> ${TMP}.tex
     echo "\newcommand*\infofont[1]{"        >> ${TMP}.tex
     echo "\textsf{\small\vspace{1em}#1}}"   >> ${TMP}.tex
     echo "\usepackage[cam,a4,landscape,"    >> ${TMP}.tex
     echo "            center,axes,"         >> ${TMP}.tex
     echo "            font=infofont,"       >> ${TMP}.tex
     echo "            color=cropblack,"     >> ${TMP}.tex
     echo "            pdftex]"              >> ${TMP}.tex
     echo "{crop}"                           >> ${TMP}.tex
    
     fi

     echo "\begin{document}"                 >> ${TMP}.tex
     echo "\includepdf[noautoscale,"         >> ${TMP}.tex
     echo "            nup=2x1,"             >> ${TMP}.tex            
     echo "            pages={${PAGES}}]"    >> ${TMP}.tex
     echo "{"`realpath $PDF`"}"              >> ${TMP}.tex
     echo "\end{document}"                   >> ${TMP}.tex
    
     pdflatex -interaction=nonstopmode ${TMP}.tex > /dev/null

     if [ "$F" == "PLAIN" ]
     then gs -q  -o - -sDEVICE=inkcov ${TMP}.pdf > ${TMP}.info
     fi

 done


 for R in log aux tex;do rm ${TMP}.${R};done


exit 0;

