FROM rocker/r-ver:3.6.1
RUN apt-get update && apt-get install -y imagemagick libcurl4-openssl-dev libmagic-dev libmagick++-dev libpng-dev libsasl2-dev libssh2-1-dev libssl-dev libxml2-dev make pandoc pandoc-citeproc zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.4.0.2")'
RUN Rscript -e 'remotes::install_version("golem",upgrade="never", version = "0.2.1")'
RUN Rscript -e 'remotes::install_version("hexSticker",upgrade="never", version = "0.4.6")'
RUN Rscript -e 'remotes::install_version("sysfonts",upgrade="never", version = "0.8")'
RUN Rscript -e 'remotes::install_version("pkgload",upgrade="never", version = "1.0.2")'
RUN Rscript -e 'remotes::install_version("magick",upgrade="never", version = "2.3")'
RUN Rscript -e 'remotes::install_version("fs",upgrade="never", version = "1.4.1")'
RUN Rscript -e 'remotes::install_version("R6",upgrade="never", version = "2.4.1")'
RUN Rscript -e 'remotes::install_version("attempt",upgrade="never", version = "0.3.1")'
RUN Rscript -e 'remotes::install_version("base64enc",upgrade="never", version = "0.1-3")'
RUN Rscript -e 'remotes::install_version("cicerone",upgrade="never", version = "1.0.1")'
RUN Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3")'
RUN Rscript -e 'remotes::install_version("mongolite",upgrade="never", version = "2.2.0")'
RUN Rscript -e 'remotes::install_version("markdown",upgrade="never", version = "1.1")'
RUN Rscript -e 'remotes::install_version("purrr",upgrade="never", version = "0.3.4")'
RUN Rscript -e 'remotes::install_version("digest",upgrade="never", version = "0.6.25")'
RUN Rscript -e 'remotes::install_version("knitr",upgrade="never", version = "1.28")'
RUN Rscript -e 'remotes::install_version("magrittr",upgrade="never", version = "1.5")'
RUN Rscript -e 'remotes::install_version("glue",upgrade="never", version = "1.4.0")'
RUN Rscript -e 'remotes::install_github("rstudio/htmltools@a8025f360d70c67d41610e12f5a9ee6349327060")'
RUN Rscript -e 'remotes::install_github("yonicd/whereami@64ee46b4222bc03aa13ee3bc1eb2750e450cb057")'
RUN Rscript -e 'remotes::install_github("r-lib/fastmap@61c609993a40b8101b141b2c940bf8ccbaef4dfa")'
RUN Rscript -e 'remotes::install_github("r-lib/lifecycle@355dcba8530bcce57c15847165ca568f9f81b43e")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'
EXPOSE 80
ENV WITHMONGO 0
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');hexmake::run_app(with_mongo = $WITHMONGO)"
