    

    #Working directory: GETWD, SETWD

  setwd("... Main Documents")
  
  data=read.csv(".../Incidence11_15.csv")
  
  View(data)
  
  saveRDS(data, "data.rds", ascii=TRUE)
  
    #Good help here: http://www.cookbook-r.com/Data_input_and_output/Writing_data_to_a_file/
 
  data = readLines("...incidence11_15.txt")

  
  ######################################################################################################
  
      #From the webpage:  http://www.cookbook-r.com/Data_input_and_output/Writing_data_to_a_file/
  
      # A sample data frame
  
   data <- read.table(header=TRUE, text='
                     subject sex size
                     1   M    7
                     2   F    NA
                     3   F    9
                     4   M   11
                     ')
  
  
      # Write to a file, suppress row names
  
    write.csv(data, "data.csv", row.names=FALSE)
  
      # Same, except that instead of "NA", output blank cells
  
    write.csv(data, "data.csv", row.names=FALSE, na="")
  
    # Use tabs, suppress row names and column names
    
    write.table(data, "data.csv", sep="\t", row.names=FALSE, col.names=FALSE) 
    
    
    ##Saving in R data format
    
      # Save in a text format that can be easily loaded in R
    
    dump("data", "data.Rdmpd")
    
      # Can save multiple objects:
    
    dump(c("data", "data1"), "data.Rdmpd")
    
      # To load the data again: 
    
    source("data.Rdmpd")
    
      # When loaded, the original data names will automatically be used.
    
    ###
    
      # Save a single object in binary RDS format
    
    saveRDS(data, "data.rds")
    
      # Or, using ASCII format
    
    saveRDS(data, "data.rds", ascii=TRUE)
    
      # To load the data again:
    
    data <- readRDS("data.rds")
    
    ###
    
      # Saving multiple objects in binary RData format
    
    save(data, file="data.RData")
    
      # Or, using ASCII format
    
    save(data, file="data.RData", ascii=TRUE)
    
      # Can save multiple objects
    
    save(data, data1, file="data.RData")
    
      # To load the data again:
    
    load("data.RData")
    

    ###################################
    
    #Loading data from a file:
    
    
    data <- read.csv("datafile.csv")
    
    data <- read.csv("datafile-noheader.csv", header=FALSE) # File with no headers
    
    data <- read.table("datafile-noheader.csv",
                       header=FALSE,
                       sep=","         # use "\t" for tab-delimited files for seperator
                      )
    
    data <- read.csv(file.choose()) #This is file Chooser - will open a file chooser dialog window
    
    # Treating strings as factors
    
    data <- read.csv("datafile.csv", stringsAsFactors=FALSE)
    
    data$Sex <- factor(data$Sex)  # You might have to convert some columns to factors
    
    #Load them as character
    
    data <- read.csv("datafile.csv")
    
    data$First <- as.character(data$First)
    data$Last  <- as.character(data$Last)
    
    # Another method: convert columns named "First" and "Last"
    stringcols <- c("First","Last")
    data[stringcols] <- lapply(data[stringcols], as.character)
    
    #Loading the data from the internet
    
    data <- read.csv("http://www.cookbook-r.com/Data_input_and_output/Loading_data_from_a_file/datafile.csv")
    
    
    # Read in a CSV file without headers
    data <- read.csv("http://www.cookbook-r.com/Data_input_and_output/Loading_data_from_a_file/datafile-noheader.csv", header=FALSE)
    
    # Manually assign the header names
    names(data) <- c("First","Last","Sex","Number")
    
    #However, your data file may have columns containing spaces, or columns with no spaces separating them, 
    #like this, where the scores column represents six different measurements, each from 0 to 3.
    
    subject  sex  scores
    N  1    M  113311
    NE 2    F  112231
    S  3    F  111221
    W  4    M  011002
    
    
    #In this case, you may need to use the read.fwf() function. If you read the column names from the file, 
    #it requires that they be separated with a delimiter like a single tab, space, or comma. 
    #If they are separated with multiple spaces, as in this example, you will have to assign the column names directly.
    
    # Assign the column names manually
    read.fwf("myfile.txt", 
             c(7,5,-2,1,1,1,1,1,1), # Width of the columns. -2 means drop those columns
             skip=1,                # Skip the first line (contains header here)
             col.names=c("subject","sex","s1","s2","s3","s4","s5","s6"),
             strip.white=TRUE)      # Strip out leading and trailing whitespace when reading each
    #>   subject sex s1 s2 s3 s4 s5 s6
    #> 1    N  1   M  1  1  3  3  1  1
    #> 2    NE 2   F  1  1  2  2  3  1
    #> 3    S  3   F  1  1  1  2  2  1
    #> 4    W  4   M  0  1  1  0  0  2
    # subject sex s1 s2 s3 s4 s5 s6
    #    N  1   M  1  1  3  3  1  1
    #    NE 2   F  1  1  2  2  3  1
    #    S  3   F  1  1  1  2  2  1
    #    W  4   M  0  1  1  0  0  2
    
    
    # If the first row looked like this:
    # subject,sex,scores
    # Then we could use header=TRUE:
    read.fwf("myfile.txt", c(7,5,-2,1,1,1,1,1,1), header=TRUE, strip.white=TRUE)
    #> Error in read.table(file = FILE, header = header, sep = sep, row.names = row.names, : more columns than column names
    
    
    #Excel files: The read.xls function in the gdata package can read in Excel files.
    
    library(gdata)
    data <- read.xls("data.xls")
    
    
    #See http://cran.r-project.org/doc/manuals/R-data.html#Reading-Excel-spreadsheets.
    
    #SPSS data files
    
    #The read.spss function in the foreign package can read in SPSS files.
    
    library(foreign)
    data <- read.spss("data.sav", to.data.frame=TRUE)
    
    
    #####################################
    
    #Data input

    #Loading data from keyboard input or clipboard
    
    #One way enter from the keyboard is to read from standard input (stdin()).
    
    # Cutting and pasting using read.table and stdin()
    
    data <- read.table(stdin(), header=TRUE)  # You will be prompted for input; copy and paste text here
    
    # Or:
    
    data <- read.csv(stdin())
    
    
    #You can also load directly from the clipboard: First copy the data to the clipboard
    
      data <- read.table('clipboard', header=TRUE)
    
    # Or:
    data <- read.csv('clipboard')
    
    
    Loading data in a script
    
    The previous method can’t be used to load data in a script file because the input must be typed (or pasted) after running the command.
    
    # Using read.table()
    data <- read.table(header=TRUE, text='
                       size weight cost
                       small      5    6
                       medium      8   10
                       large     11    9
                       ')
    
    
    For different data formats (e.g., comma-delimited, no headers, etc.), options to read.table() can be set. See ../Loading data from a file for more information.
    
    Data output
    
    By default, R prints row names. If you want to print the table in a format that can be copied and pasted, it may be useful to suppress them.
    
    print(data, row.names=FALSE)
    #>    size weight cost
    #>   small      5    6
    #>  medium      8   10
    #>   large     11    9
    
    
    Writing data for copying and pasting, or to the clipboard
    
    It is possible to write delimited data to terminal (stdout()), so that it can be copied and pasted elsewhere. Or it can be written directly to the clipboard.
    
    write.csv(data, stdout(), row.names=FALSE)
    # "size","weight","cost"
    # "small",5,6
    # "medium",8,10
    # "large",11,9
    
    
    # Write to the clipboard (does not work on Mac or Unix)
    write.csv(data, 'clipboard', row.names=FALSE)
    
    
    Output for loading in R
    
    If the data has already been loaded into R, the data structure can be saved using dput(). The output from dput() is a command which will recreate the data structure. The advantage of this method is that it will keep any modifications to data types; for example, if one column consists of numbers and you have converted it to a factor, this method will preserve that type, whereas simply loading the text table (as shown above) will treat it as numeric.
    
    # Suppose you have already loaded data
    
    dput(data)
    #> structure(list(size = structure(c(3L, 2L, 1L), .Label = c("large", 
    #> "medium", "small"), class = "factor"), weight = c(5L, 8L, 11L
    #> ), cost = c(6L, 10L, 9L)), .Names = c("size", "weight", "cost"
    #> ), class = "data.frame", row.names = c(NA, -3L))
    
    
    # Later, we can use the output from dput to recreate the data structure
    newdata <- structure(list(size = structure(c(3L, 2L, 1L), .Label = c("large", 
                                                                         "medium", "small"), class = "factor"), weight = c(5L, 8L, 11L
                                                                         ), cost = c(6L, 10L, 9L)), .Names = c("size", "weight", "cost"
                                                                         ), class = "data.frame", row.names = c(NA, -3L))
    
    
    
    
  ###########################################
    
    #Writing text and output from analyses to file
    
    #The sink() function will redirect output to a file instead of to the R terminal. 
    #Note that if you use sink() in a script and it crashes before output is returned to the terminal, 
    #then you will not see any response to your commands. 
    #Call sink() without any arguments to return output to the terminal.
    
    # Start writing to an output file
    
    sink('analysis-output.txt')
    
    set.seed(12345)
    x <-rnorm(10,10,1)
    y <-rnorm(10,11,1)
    # Do some stuff here
    cat(sprintf("x has %d elements:\n", length(x)))
    print(x)
    cat("y =", y, "\n")
    
    cat("=============================\n")
    cat("T-test between x and y\n")
    cat("=============================\n")
    t.test(x,y)
    
    # Stop writing to the file
    sink()
    
    
    # Append to the file
    sink('analysis-output.txt', append=TRUE)
    cat("Some more stuff here...\n")
    sink()
    
    
    ## Running a script
    
    x <- 1:10
    x
    print(x)
    
    cat(x)
    
    #############
    
    # First, go to the proper directory
    setwd('/home/username/desktop/rcode')
    
    source('analyze.r')
    
    x <- 1:10
    
    # In a script, this will do nothing
    x
    
    # Use the print function:
    print(x)
    #> [1]  1  2  3  4  5  6  7  8  9 10
    
    
    # Simpler output: no row/column numbers, no text wrapping
    cat(x)
    #> 1  2  3  4  5  6  7  8  9 10
    
    
    
    
    
    
    
    
    
