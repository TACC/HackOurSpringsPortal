# Austin Spring Visualization
This repository is the data visualization team's product from the HackOurSprings hackathon sponsored by TACC on March 3rd, 2016. It contains the scripts to create this [Austin well data visualization](https://vimeo.com/207183644), which should be able to be fully recreated if you run the script successfully.

# Running Instructions
## Preliminaries
Before running the script you will need to install [R](https://www.r-project.org/), and I'd suggest installing [RStudio](https://www.rstudio.com/) as well. If you would like to create the .mp4 at the end of the script you will also need to install [ffmpeg](https://ffmpeg.org/).

## Downloading Data
The data can be found on the Barton Springs Edward Aquifer Conservation District's (BSEACD) [hackathon website](http://bseacd.org/hackathon/), and should be downloadable  [from this link](http://bseacd.org/uploads/MonitorWells_daily_Excel_201703.zip). 

Once downloaded and unzipped, move the `Crosstab_AllSites_daily_min.xlsx` and `Sites_with_summary.xlsx` files to the empty data folder located within this repository.

## Running the Script
With everything installed (or at least RStudio and R), you can double click on the `well_viz.Rproj` file, and open the `R/viz_script.R` file from within the project. The script uses a number of R packages that you will need to make sure are [installed](http://web.cs.ucla.edu/~gulzar/rstudio/). Packages used that will need to be installed: 

- readxl 
- tidyverse 
- ggmap 
- cowplot 
- gganimate 
- ggrepel 
- scales 
- RColorBrewer

Once the packages are installed, and the data are placed correctly, you can select all of the code and run the script to produce the movie which will show up in the videos folder. It takes ~10 minutes or so to run the script.

# Contact Information
If you have any issues, questions, or comments about the script, please contact me on twitter ([@foxandtheflu](https://twitter.com/foxandtheflu)) or via [email](mailto: spncrfx@gmail.com).
