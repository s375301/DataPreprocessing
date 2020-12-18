### name : character
### id, trip : integer
### lat, lng : double
### location : character
library(readr)
data_iot <- read_csv("data_iot_1_5.csv",
                         col_types = cols(name = col_character(),
                                          id = col_integer()), locale = locale(encoding = "EUC-KR"))

####################################################
###function : get IOT data by id & trip number
IOT_by_id <- function(data_iot){
  IOT <- data_iot
  N <- 1

  OPR <- function(){
    ###save file name before removal

    for(i in seq(length(unique(IOT[IOT$id == N,]$trip)))) {

      file_name <- paste0("data_iot_", IOT$id[1], "_", IOT$trip[1], ".csv")

      STD <- IOT$id == N & IOT$trip == IOT$trip[1]
      ROUTE <- IOT[STD, ]
      assign("IOT", IOT[!STD, ], envir = parent.env(environment()))

      ###save file
      write.csv(ROUTE, file=file_name, row.names = FALSE)
    }

    assign("N", N + 1, envir = parent.env(environment()))

  }

  list(opr = OPR)
}
######################################################

operation <- IOT_by_id(data_iot)
operation1 <- operation$opr

###repeat extracting
for (value in seq(5)) {
  operation1()
}

###check-up
length(unique(data_iot[data_iot$id == 1,]$trip))
length(unique(data_iot[data_iot$id == 2,]$trip))
length(unique(data_iot[data_iot$id == 3,]$trip))
length(unique(data_iot[data_iot$id == 4,]$trip))
length(unique(data_iot[data_iot$id == 5,]$trip))

###check-up NA
table(is.na(data_iot[data_iot$id == 5,]$trip))
