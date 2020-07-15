FROM rocker/shiny-verse:3.6.1

RUN R -e "install.packages('remotes');remotes::install_github("ColinFay/golemhtmltemplate")"

EXPOSE 2811

CMD ["R", "-e", "options(shiny.host = '0.0.0.0');options(shiny.port = 2811);golemhtmltemplate::run_app()"]