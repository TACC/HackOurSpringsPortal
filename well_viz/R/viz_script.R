rm(list=ls())
library(readxl)
library(tidyverse)
library(ggmap)
library(cowplot)
library(gganimate)
library(ggrepel)
library(scales)
library(RColorBrewer)
## Read in the two excel spreadsheets
well_depth <- read_excel("data/Crosstab_AllSites_daily_min.xlsx", sheet = 1)
well_info <- read_excel("data/Sites_with_summary.xlsx", sheet=1)


## Get the well data in format for plotting
well_info <- well_info %>% select(SiteID, DD_Lat, DD_Long)
well_data <- well_depth %>% rename(date = Expr1) %>% 
  gather(well, depth, -1) %>%
  left_join(well_info, by = c("well" = "SiteID")) 
  

## Now subset the data and summarize it by week so it's of manageable size
well_subset <- well_data %>% # filter(lubridate::year(date) > 2005) %>%
  group_by(well, lubridate::week(date), lubridate::year(date)) %>% 
  summarize(avg_depth = mean(depth, na.rm=T),
            DD_Lat = unique(DD_Lat),
            DD_Long = unique(DD_Long),
            date=min(date)) %>% ungroup() %>%
  group_by(well) %>%
  mutate(avg_depth = ifelse(is.nan(avg_depth), NA, avg_depth)) %>%
  mutate(std_depth = - as.numeric(scale(avg_depth))  ,
         alpha_ind = ifelse(is.na(std_depth), "a", "b")) %>%
  select(date, well, DD_Lat, DD_Long, std_depth, alpha_ind) 

## First get the map background image
base_map <- get_googlemap("manchaca texas", zoom = 11, scale = 2, color = "bw") %>% ggmap() + cowplot::theme_nothing()

## Setup colors for the plotting
cols <- brewer.pal(5, name = "RdYlBu")

## Setup the ggplot (frame=date controls the animated portion)
animated_p <- base_map + geom_point(data = well_subset, 
                                    aes(x = DD_Long, y = DD_Lat, color = std_depth, frame = date, alpha = alpha_ind),size=20)+
  scale_color_gradientn(name = "Depth", colors = cols, 
                         values = scales::rescale(c(-6, -1, 0, 1, 6))) +  
  scale_alpha_manual(values = c("a" = 0, "b" = 1), guide=FALSE) +
  theme(legend.position = c(0.9, 0.2)) +
  guides(color=guide_colorbar(barheight = 10))

## Save animation to movie -- This step necessitates ffmpeg being installed on your computer
gganimate(animated_p, filename = "videos/full_well_data.mp4", ani.width = 1600, ani.height = 900, interval = 0.2)

###################################################################
## Unused code for starting the onion creek flow monitor addition
###################################################################

# dw_lat <- 30.083281
# dw_lon <- -98.008403
# driftwood_flow <- read_tsv("data/dv.txt", skip = 30) %>%
#   slice(-1) 
# driftwood_data <- driftwood_flow %>% rename(flow = `136161_00060_00003`) %>%
#   select(datetime, flow) %>%
#   group_by(lubridate::year(datetime), lubridate::week(datetime)) %>%
#   mutate(flow = as.numeric(flow)) %>%
#   summarize(date = min(datetime), avg_flow = mean(flow, na.rm=T)) %>%
#   mutate(DD_Long = dw_lon, DD_Lat = dw_lat,
#          std_depth = as.numeric(scale(avg_flow)),
#          well = "driftwood") %>% ungroup() %>%
#   select(-(1:2), -avg_flow) %>%
#   mutate(alpha_ind = ifelse(is.na(std_depth), "a", "b")) %>%
#   mutate(date = lubridate::ymd(date))
