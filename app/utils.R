# Dashboard Climate and Engine Source Files

# Dependency List
package_list <- c("shiny",
                "shinydashboard",
                "shinycssloaders",
                "tidyverse",
                "leaflet",
                "plotly",
                "sp",
                "leaflet.extras",
                "gt",
                "data.table",
                "here")

# install any dependency not already installed
uninstalled_packages <- package_list[!(package_list %in% installed.packages()[, "Package"])]
if(length(uninstalled_packages)) install.packages(uninstalled_packages)

# load packages 
lapply(package_list, require, character.only = TRUE)

# set root directory
rootdir <- paste(here(), "/", sep ="")

# Data Sourcing/Plotting
source(paste(rootdir, "app/data_utils.R", sep = ""))
source(paste(rootdir, "app/plot_utils.R", sep = ""))