###import file
#install.packages(c("readr","dplyr"))
library(readr)
CONV_KATEC_MAPPY_GPS_1201 <- read_csv("C:/Users/smartmobility/Desktop/LIVE_201712/1201/CONV_KATEC_MAPPY_GPS.1201.csv", 
                                      col_names = FALSE, locale = locale(), 
                                      na = "NA")

###remove NA
CONV_KATEC_MAPPY_GPS_1201 <- na.omit(CONV_KATEC_MAPPY_GPS_1201)

###colnames & remove sp data
colnames(CONV_KATEC_MAPPY_GPS_1201) <- c("obu_id","date_ymd","date_time","x0","y0"
                                         ,"x1","y1","sp1"
                                         ,"x2","y2","sp2"
                                         ,"x3","y3","sp3"
                                         ,"x4","y4","sp4"
                                         ,"x5","y5","sp5"
                                         ,"x6","y6","sp6"
                                         ,"x7","y7","sp7"
                                         ,"x8","y8","sp8"
                                         ,"x9","y9","sp9"
                                         ,"x10","y10","sp10"
                                         ,"x11","y11","sp11"
                                         ,"x12","y12","sp12"
                                         ,"x13","y13","sp13"
                                         ,"x14","y14","sp14"
                                         ,"x15","y15","sp15"
                                         ,"x16","y16","sp16"
                                         ,"x17","y17","sp17"
                                         ,"x18","y18","sp18"
                                         ,"x19","y19","sp19")
CONV_KATEC_MAPPY_GPS_1201 <- CONV_KATEC_MAPPY_GPS_1201[,-c(8,11,14,17,20,23,26,29,32,35,38,41,44,47,50,53,56,59,62)]
###head(CONV_KATEC_MAPPY_GPS_1201, 3)

###STEP1 : NEW XY
STEP1 <- function(CONV_KATEC_MAPPY_GPS_1201) {
  GIS <- CONV_KATEC_MAPPY_GPS_1201
  
  NEW_XY <- function(){
  
    GIS$x1 <- GIS$x1 + GIS$x0
    GIS$y1 <- GIS$y1 + GIS$y0
    
    GIS$x2 <- GIS$x2 + GIS$x1
    GIS$y2 <- GIS$y2 + GIS$y1
    
    GIS$x3 <- GIS$x3 + GIS$x2
    GIS$y3 <- GIS$y3 + GIS$y2
    
    GIS$x4 <- GIS$x4 + GIS$x3
    GIS$y4 <- GIS$y4 + GIS$y3
    
    GIS$x5 <- GIS$x5 + GIS$x4
    GIS$y5 <- GIS$y5 + GIS$y4
    
    GIS$x6 <- GIS$x6 + GIS$x5
    GIS$y6 <- GIS$y6 + GIS$y5
    
    GIS$x7 <- GIS$x7 + GIS$x6
    GIS$y7 <- GIS$y7 + GIS$y6
    
    GIS$x8 <- GIS$x8 + GIS$x7
    GIS$y8 <- GIS$y8 + GIS$y7
    
    GIS$x9 <- GIS$x9 + GIS$x8
    GIS$y9 <- GIS$y9 + GIS$y8
    
    GIS$x10 <- GIS$x10 + GIS$x9
    GIS$y10 <- GIS$y10 + GIS$y9
    
    GIS$x11 <- GIS$x11 + GIS$x10
    GIS$y11 <- GIS$y11 + GIS$y10
    
    GIS$x12 <- GIS$x12 + GIS$x11
    GIS$y12 <- GIS$y12 + GIS$y11
    
    GIS$x13 <- GIS$x13 + GIS$x12
    GIS$y13 <- GIS$y13 + GIS$y12
    
    GIS$x14 <- GIS$x14 + GIS$x13
    GIS$y14 <- GIS$y14 + GIS$y13
    
    GIS$x15 <- GIS$x15 + GIS$x14
    GIS$y15 <- GIS$y15 + GIS$y14
    
    GIS$x16 <- GIS$x16 + GIS$x15
    GIS$y16 <- GIS$y16 + GIS$y15
    
    GIS$x17 <- GIS$x17 + GIS$x16
    GIS$y17 <- GIS$y17 + GIS$y16
    
    GIS$x18 <- GIS$x18 + GIS$x17
    GIS$y18 <- GIS$y18 + GIS$y17
    
    GIS$x19 <- GIS$x19 + GIS$x18
    GIS$y19 <- GIS$y19 + GIS$y18
    
    assign("CONV_KATEC_MAPPY_GPS_1201", GIS, envir = globalenv())
    }
  list(new_xy = NEW_XY)
  }

step1 <- STEP1(CONV_KATEC_MAPPY_GPS_1201)
step1_opr <- step1$new_xy
step1_opr()

###remove objects, values, functions for step1
rm(step1)
rm(STEP1)
rm(step1_opr)
gc()

###searching unique IDs
unique_ids <- unique(CONV_KATEC_MAPPY_GPS_1201$obu_id)
length(unique_ids)

###save obu_id_list
write.table(x = unique_ids, file = "obu_id_list_1201.csv", sep = ",", row.names = F, col.names = F, quote = F)

###STEP2 : get GPS data by obu_id
STEP2 <- function(CONV_KATEC_MAPPY_GPS_1201){
  GPS_1201 <- CONV_KATEC_MAPPY_GPS_1201
  
  GPS_BY_ID <- function(){
    ###save file name before removal
    OBU_ID <- GPS_1201[1, 1]
    file_name <- paste0(OBU_ID, ".csv")
    
    STD <- GPS_1201$obu_id == GPS_1201$obu_id[1]
    ROUTE <- GPS_1201[STD, ]
      
    assign("GPS_1201", GPS_1201[-STD, ], envir = parent.env(environment()))
    
    ###save file
    write.csv(ROUTE, file=file_name, row.names = FALSE)
    }
  
  list(gps_by_id = GPS_BY_ID)
}

step2 <- STEP2(CONV_KATEC_MAPPY_GPS_1201)
step2_opr <- step2$gps_by_id

###just for 1 trial
step2_opr()

###remove objects, values, functions for step2
rm(step2)
rm(STEP2)
rm(step2_opr)

###repeat extracting !!!CAUTION : requires a day!!!
for (value in unique_ids) {
  step2_opr()
}

###STEP3 : xy platter

n <- 1

for (value in unique_ids) {
  input_file <- paste0(readLines("obu_id_list_1201.csv")[n], ".csv")
  output_file <- paste0(readLines("obu_id_list_1201.csv")[n], "(1)", ".csv")
  ROUTE <- read_csv(input_file, col_names = T, locale = locale(), na = "NA")
  colnames(ROUTE) <- NA
  OBU_ID <- ROUTE[1,1]
  
  ###remove data from yesterday, obu_id, ymd 
  yesterday <- ROUTE[,2] < 20171201 ###date of travel
  ROUTE <- ROUTE[- yesterday, - c(1,2)]
  
  STEP3 <- function(ROUTE) {
    DF <- ROUTE
    
    ROW_TO_COL <- function() {
      DATE_TIME <- as.double(DF[1,1])
      trip <- as.double(DF[1, -1]) ###time removal
      
      GPS <- matrix(trip, ncol = 2, byrow = T) ###GPS = XY Coordinates for 1min
      GPS <- cbind(rep(as.double(OBU_ID), 20), rep((DATE_TIME), 20), GPS)
      
      assign("DF", DF[-1, ], envir = parent.env(environment()))
      
      
      ###save csv file
      write.table(GPS, file = output_file, sep = ",", row.names = F, col.names = F, quote = F, append = T, na = "NA")
    }
    list(row_to_col = ROW_TO_COL)
  }
  
  step3 <- STEP3(ROUTE)
  step3_opr <- step3$row_to_col
  
  ###for
  for(i in 1:nrow(ROUTE)){
    step3_opr()
  }
  assign ("n", n + 1, envir = globalenv())
}

################################################################################
###function - repeat
###input_file <- paste0(readLines("obu_id_list_1201.csv")[1], ".csv")
###output_file <- paste0(readLines("obu_id_list_1201.csv")[1], "(1)", ".csv")
###ROUTE <- read_csv(input_file, col_names = T, locale = locale(), na = "NA")
###colnames(ROUTE) <- NA
###OBU_ID <- ROUTE[1,1]
###
######remove data from yesterday, obu_id, ymd 
###yesterday <- ROUTE[,2] < 20171201 ###date of travel
###ROUTE <- ROUTE[- yesterday, - c(1,2)]
###
###STEP3 <- function(ROUTE) {
###  DF <- ROUTE
###  
###  ROW_TO_COL <- function() {
###    DATE_TIME <- as.double(DF[1,1])
###    trip <- as.double(DF[1, -1]) ###time removal
###    
###    GPS <- matrix(trip, ncol = 2, byrow = T) ###GPS = XY Coordinates for 1min
###    GPS <- cbind(rep(as.double(OBU_ID), 20), rep((DATE_TIME), 20), GPS)
###    
###    assign("DF", DF[-1, ], envir = parent.env(environment()))
###    
###    
###    ###save csv file
###    write.table(GPS, file = output_file, sep = ",", row.names = F, col.names = F, quote = F, append = T, na = "NA")
###  }
###  list(row_to_col = ROW_TO_COL)
###}
###
###step3 <- STEP3(ROUTE)
###step3_opr <- step3$row_to_col
###
######for
###for(i in 1:nrow(ROUTE)){
###  step3_opr()
###}
###
######remove objects, values, functions for step3
###rm(step3)
###rm(STEP3)
###rm(step3_opr)
###rm(input_file)
###rm(output_file)
###rm(yesterday)
###rm(ROUTE)
###rm(OBU_ID)
