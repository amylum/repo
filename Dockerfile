FROM ghcr.io/dock0/build
RUN pacman -S --needed --noconfirm namcap
RUN gem install --no-doc --no-user-install s3repo
RUN useradd -m --uid 501 build
RUN chown build:build /opt/build
USER build
