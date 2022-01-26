# start from the rocker/r-ver:3.5.0 image
FROM rocker/r-ver:4.1.1

# install xdg-open
RUN apt-get update -qq && apt-get install -y xdg-utils --fix-missing

#Set the local browser to be FIREFOX
RUN export BROWSER='/mnt/c/Program Files/Mozilla Firefox/firefox.exe'

# install
RUN R -e "install.packages(c('here', 'pander'))"

# copy model and scoring script
WORKDIR /app
RUN mkdir /app/css

# Copy over the files I need
ADD ./R/launch_html_page.R /app/
ADD ./index.html /app/
ADD ./css/main.css /app/css/

# open port 8000 to traffic
# EXPOSE 8000

# when the container starts, start the main.R script
#CMD ["Rscript", "/app/launch_html_page.R"]
CMD xdg-open /app/index.html 