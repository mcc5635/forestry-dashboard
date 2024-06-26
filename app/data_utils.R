# App Data Pull Section

# climate data aggregated to the yearly level with uncertainty
clim_dat <- fread(paste(rootdir, "/data/yearly_ci_all.csv", sep = ""))
# climate data aggregated to the yearly level with uncertainty
clim_mon <- fread(paste(rootdir, "/data/clim_dat_monthly.csv", sep = ""))

# Input Species Codes
species_code <- fread(paste(rootdir, "data/species_codes.csv", sep = "")) %>% select(c(COMMON_NAME, SPECIES_CODE))

# Add Acreage Info
hist_clim_x_tree_dat <- fread(paste(rootdir, "data/historical_climate_tree_data_cleaned.csv", sep = ""), sep=",", header=TRUE)

# Data for Map Shading
background_map <- fread(paste(rootdir, "data/background_heatmap.csv", sep = ""))
multipoly <- background_map %>% dplyr::select(LON, LAT) %>% dplyr::distinct()
multipoly <- SpatialPointsDataFrame(multipoly[,c("LON","LAT")],multipoly)