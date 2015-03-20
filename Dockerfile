FROM dock0/ssh
MAINTAINER akerl <me@lesaker.org>
RUN pacman -S --noconfirm make
RUN su - $ADMIN -c 'git clone git://github.com/amylum/repo ~/repo'
RUN su - $ADMIN -c 'git -C ~/repo remote set-url origin git@github.com:amylum/repo'

