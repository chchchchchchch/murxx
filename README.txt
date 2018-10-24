---------------------------------------------------------------
 M U R   X X
---------------------------------------------------------------

Making a book 
after 20 years
of https://mur.at


MORE INFORMATION COMING SOON


===============================================================
 H O W   T O . . .
===============================================================

Installing fonts for LaTeX
---------------------------------------------------------------

Download font files at https://fontain.org e.g.
https://fontain.org/junicode/export/tex/junicode.tex.zip

### For the first time

- Install LaTeX (texlive-latex-base)
  e.g. `sudo aptitude install texlive-latex-base`
 _or_ use the software center
 _or_ download it from the internet.

- Find out about your TEXMFHOME directory
 `kpsewhich --var-value=TEXMFHOME`

#### Approach 1

- If there is no TEXMFHOME directory create it
  e.g. `mkdir ~/.TEXMF`
- and add it to your configuration
 `sudo tlmgr conf texmf TEXMFHOME "~/.TEXMF"`

#### Approach 2

- `cd /etc/texmf/texmf.d`
- `sudo touch 00_texmfhome.cnf`
- `sudo echo "TEXMFHOME = ~/.TEXMF" > 00_texmfhome.cnf`
- `sudo update-texmf`
- `kpsexpand \$TEXMFHOME`

### To install the font

- Add the content of the TEXMF directory inside
  junicode.texmf.zip to your TEXMFHOME directory
  (copy over existing folders)

- Add the line `Map pju.map`
  to the file $TEXMFHOME/web2c/updmap.cfg
  (If the file/directory does not exist create it!)

- Update your TeX installation
 `updmap`

- Compile the testpage example_junicode.tex
 `pdflatex example_junicode.tex





===============================================================

 If not stated otherwise permission is granted to copy,
 distribute and/or modify these documents under the terms
 of any of the following licenses (LICENSES.txt)
 
 EXECUTABLE CODE | COPYRIGHT (C) 2018 Christoph Haag
 ---------------
 
 the GNU General Public License as published by the Free
 Software Foundation; either version 3 of the License,
 or (at your option) any later version.
 --
 http://www.gnu.org/licenses/gpl.txt
 
 
 THE REST  | COPYRIGHT (C) 2018 Christoph Haag
 --------
 
 the Creative Commons Attribution-ShareAlike License;
 either version 3.0 of license or any later version.
 --
 http://creativecommons.org/licenses/by-sa/3.0
 
 
 These documents are distributed in the hope that it
 will  be useful, but WITHOUT ANY WARRANTY; without even
 the implied warranty of MERCHANTABILITY or FITNESS FOR
 A PARTICULAR PURPOSE.
 
 Your fair use and other rights are not affected by the above.
 
 TRADEMARKS, QUOTED MATERIAL AND LINKED CONTENT
 IS COPYRIGHTED ACCORDING TO ITS RESPECTIVE OWNERS.
 
 E N J O Y !

===============================================================

