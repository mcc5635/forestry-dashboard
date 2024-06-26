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


# Load data
sel_CMIP5_dat <- function(locations) {
  
  # find closest location with available data
  LATS <- clim_dat$LAT
  LONS <- clim_dat$LON
  
  # iterate through selected points to find nearest data
  locs <- data.frame(LAT = c(), LON = c())
  for (i in 1:dim(locations)[1]){
    close_lat <- LATS[which.min(abs(LATS-locations[i,]$LAT))]
    close_lon <- LONS[which.min(abs(LONS-locations[i,]$LON))]
    locs <- rbind(locs, c(close_lat, close_lon))
  }
  locs <- locs %>% rename(LAT = 1, LON = 2)
  
  
  # select data corresponding to these points
  dat_all_locs <- subset(clim_dat, (LAT %in% locs$LAT) & (LON %in% locs$LON)) %>% drop_na()
  dat_all_locs <- dat_all_locs %>% select(c(-X, -LAT, -LON))
  
  # summarize across all selected locations
  dat_combi <- dat_all_locs %>% group_by(YR, RCP) %>% 
    summarize(mean_temp = mean(meantmp), mean_temp_LB = mean(meantmp.1), mean_temp_UB = mean(meantmp.2),
              max_temp = mean(maxtmp), max_temp_LB = mean(maxtmp.1), max_temp_UB = mean(maxtmp.2),
              min_temp = mean(mintmp), min_temp_LB = mean(mintmp.1), min_temp_UB = mean(mintmp.2),
              precip = mean(precip), precip_LB = mean(precip.1), precip_UB = mean(precip.2)) %>%
    ungroup()
  return(dat_combi)
}

sel_CMIP5_mon <- function(locations) {

# continue indexing location here


}


summary_stats <- function(dat, year1, year2, RCP){

    yr1 <- dat %>%
        drop_na() %>%
        dplyr::filter(YR == year1 &
                RCP == RCP)
    yr2 <- dat %>%
        drop_na() %>%
        dplyr::filter(YR == year2 &
                RCP == RCP)


}