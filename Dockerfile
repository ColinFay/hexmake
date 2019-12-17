FROM rocker/r-ver:3.6.1
RUN apt-get update && apt-get install -y  git-core imagemagick libcurl4-openssl-dev libmagic-dev libmagick++-dev libpng-dev libssh2-1-dev libssl-dev libxml2-dev make zlib1g-dev
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes")'
RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.4.0")'
RUN Rscript -e 'remotes::install_github("thinkr-open/golem", upgrade = "never")'
RUN Rscript -e 'remotes::install_version("htmltools",upgrade="never", version = "0.4.0")'
RUN Rscript -e 'remotes::install_version("hexSticker",upgrade="never", version = "0.4.6")'
RUN Rscript -e 'remotes::install_version("sysfonts",upgrade="never", version = "0.8")'
RUN Rscript -e 'remotes::install_version("pkgload",upgrade="never", version = "1.0.2")'
RUN Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'
EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');hexmake::run_app()"
