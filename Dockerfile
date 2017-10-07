FROM dock0/build
RUN pacman -S --needed --noconfirm namcap
RUN gem install --no-user-install s3repo prospectus octoauth
