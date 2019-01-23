FROM debian:wheezy
RUN rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-lang-german \
    texlive-fonts-recommended \
    texlive-extra-utils \
    texlive-bibtex-extra \
    latex-xcolor \
    etoolbox \
    pandoc \
    biber \
    make \
    wget \
    curl \
    file \
    unzip \
    git \
    ghostscript \
    inkscape \
    imagemagick \
    pdftk \
    poppler-utils \
    rsync

# things that wheezy doesn't have per default
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    coreutils \
    realpath

RUN echo "Europe/Berlin" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

WORKDIR "/murxx"
CMD ["make", "pdf"]
