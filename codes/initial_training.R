install.packages("tidyverse") #installing package for manipulating data and creating graphs
library(tidyverse) #loading package into the current workspace 

getwd() # get working directory of files

data <- read.csv("./data/Brunei_project/Project-T3.csv", header = TRUE) #read data
head(data) #look at top lines of data
data #look at the whole data
names(data) #look at the names of the data
data$site_name #look at a specific variable

names(data) #shows the names of all columns in data
data1 <- data |> #pipe to feed data into next function 
  select(site_name, #select important variables
         survey_start_date..UTC.,
         point_human_classification, 
         point_human_group_code)

data2 <- data1 |> #create new data from original
  select(-site_name) #remove site_name

data3 <- data1 |>  #create new data
  filter(point_human_group_code == "HC") #filter to find group codes for HC only

install.packages("lubridate") #install package to work with dates and time
library(lubridate) #load package

data4 <- data3 |> 
  mutate(year = year(survey_start_date..UTC.)) #create new variable using year

data5 <- data4 |> 
  mutate(transect_id = paste(site_name, #create new variable by pasting data from different variables
                             year(survey_start_date..UTC.),
                             sep = "_"))

labelset <- read.csv("./data/Brunei_project/Labelset-T3.csv", #read labelset file
                     header = TRUE) |> 
  rename(point_machine_classification = CODE, #rename variables to new names
         point_machine_group_code = FUNCTIONAL.GROUP)

data6 <- data |>  
  left_join(labelset, by = "point_machine_classification") #joining datasets
