FROM alpine:latest

WORKDIR /root

ADD vimrc /root/.vimrc

RUN set -ex \

	&& apk add --no-cache git python3 \
	&& apk add --no-cache --virtual .build-deps curl build-base ncurses-dev python3-dev \

	&& git clone https://github.com/vim/vim.git \
	&& cd vim \
	&& ./configure --enable-multibyte --enable-python3interp \
	&& make \
	&& make install \

	&& curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \

	&& apk del .build-deps \
	&& cd .. \
	&& rm -rf vim/

CMD ["/bin/sh"]
