FROM dock0/build
RUN pacman -S --needed --noconfirm namcap
RUN gem install --no-user-install s3repo prospectus octoauth
RUN useradd build
RUN chown build:build /opt/build
USER build
