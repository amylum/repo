FROM dock0/build
RUN pacman -S --needed --noconfirm namcap
RUN gem install --no-doc --no-user-install \
    s3repo \
    prospectus \
    octoauth \
    rdoc \
    prospectus_dockerhub
RUN useradd -m build
RUN chown build:build /opt/build
USER build
