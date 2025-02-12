FROM rocker/rstudio:4.4.2

USER root

RUN apt-get update && apt-get install -y \
    libssl-dev libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN Rscript -e 'install.packages("remotes", repos="https://cloud.r-project.org")' && \
    Rscript -e 'remotes::install_version("cowsay", version="0.8.0", repos="https://cloud.r-project.org")'

COPY test_cowsay.R /home/rstudio/test_cowsay.R

RUN chown rstudio:rstudio /home/rstudio/test_cowsay.R

RUN chmod -R 777 /home/rstudio

ENV PASSWORD="password"

EXPOSE 8787

WORKDIR /home/rstudio

CMD ["/init"]