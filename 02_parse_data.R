library(stringr)

read_data <- function() {
  
  files <- list.files('data', full.names = TRUE)
  
  df <- data.frame(stringsAsFactors = F)
  
  for (i in files) {
    
    csv <- read.csv(i, stringsAsFactors = F)
    
    df <- rbind.data.frame(df, csv)
  }
  
  return(df)
}

parse_data <- function(df) {
  
  df$date <- as.Date(paste(df$year, df$month, df$day, sep = "-"))
  
  df$start <- df$start %>% 
    str_extract('\\d+?:\\d+') %>% 
    strptime(format = '%H:%M', tz = 'UTC') %>% 
    as.POSIXct()
  
  df$end <- df$end %>% 
    str_extract('\\d+?:\\d+') %>% 
    strptime(format = '%H:%M', tz = 'UTC') %>% 
    as.POSIXct()
  
  return(df)
  
}

df <- parse_data(read_data())


