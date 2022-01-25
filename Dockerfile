# start from the rocker/r-ver:3.5.0 image
FROM r-ver:4.1.1

# install plumber
RUN R -e "install.packages(c('here', 'pander'))"

# copy model and scoring script
WORKDIR /app

# Inject these files in at runtime via volume mounts from local computer file system
ADD ./R/launch_html_page.R ./app/
ADD ./index.html ./app/
ADD ./css/main.css ./app/

# open port 8000 to traffic
# EXPOSE 8000

# when the container starts, start the main.R script
CMD ["Rscript", "/app/launch_html_page.R"]