FROM alpine:3.16 as swfbuild
RUN apk add --update --no-cache --virtual build-dep build-base git libjpeg-turbo-dev freetype-dev zlib-dev && \
    wget http://swftools.org/swftools-2013-04-09-1007.tar.gz && \
    tar xzf swftools-2013-04-09-1007.tar.gz && rm swftools-2013-04-09-1007.tar.gz && cd swftools* && \
    wget "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD" -O config.guess && \
    sed -i 's/config.guess"/config.guess" $(uname -m)/' configure && \
    sed -e 's/-o -L/#-o -L/' -i swfs/Makefile.in && \
    LDFLAGS="-static" ./configure && LDFLAGS="-all-static" make && \
    mv src /swftools && apk del build-dep
