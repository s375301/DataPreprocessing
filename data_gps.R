### name : character
### id, trip : integer
### lat, lng : double
### time : time
library(readr)
data_gps <- read_csv("data_gps_1_5.csv",
                     col_types = cols(name = col_character(),
                                      id = col_integer(), trip = col_integer(),
                                      time = col_time(format = "%H:%M:%S")))

####################################################
###function : get GPS data by id & trip number
GPS_by_id <- function(data_gps){
  GPS <- data_gps
  N <- 1

  OPR <- function(){
    ###save file name before removal

    for(i in seq(length(unique(GPS[GPS$id == N,]$trip)))) {

      file_name <- paste0("data_gps_", GPS$id[1], "_", GPS$trip[1], ".csv")

      STD <- GPS$id == N & GPS$trip == GPS$trip[1]
      ROUTE <- GPS[STD, ]
      assign("GPS", GPS[!STD, ], envir = parent.env(environment()))

      ###save file
      write.csv(ROUTE, file=file_name, row.names = FALSE)
    }

    assign("N", N + 1, envir = parent.env(environment()))

  }

  list(opr = OPR)
}
######################################################

operation <- GPS_by_id(data_gps)
operation1 <- operation$opr

###repeat extracting
for (value in seq(5)) {
  operation1()
}

###function : get GPS data by id
###GPS_by_id <- function(data_gps){
###  GPS <- data_gps
###  N <- 1
###
###  OPR <- function(){
###    ###save file name before removal
###    file_name <- paste0("data_gps_", GPS[1, 2], ".csv")
###
###    STD <- GPS$id == N
###    ROUTE <- GPS[STD, ]
###    assign("GPS", GPS[!STD, ], envir = parent.env(environment()))
###    assign("N", N + 1, envir = parent.env(environment()))
###
###    ###save file
###    write.csv(ROUTE, file=file_name, row.names = FALSE)
###  }
###
###  list(opr = OPR)
###}

###just for 1 trial
###operation1()

###check-up
###nrow(data_gps[data_gps$id == 5,])
length(unique(data_gps[data_gps$id == 5,]$trip))
