## @param directory
##	Character vector of length 1 indicating the
##	location of the CSV files.
##
## @param id
##	Integer vector indicating monitor id numbers to be used.
##	Default value is 1:332 (seq_len(332)).
##
## @return
##	A data frame with columns "id" and "nobs," where id is the
##	monitor ID number, and nobs is the number of complete cases.
complete <- function(directory, id = 1:332) {
	output <- data.frame()

	for (i in id) {
		inputFilePath <- file.path(directory, sprintf("%03d.csv", i))
		allInfo <- read.csv(inputFilePath)
		numCompleteCases <- length(allInfo[complete.cases(allInfo), "ID"])
		output <- rbind(output, c(i, numCompleteCases)) 
	}

	colnames(output) <- c("id", "nobs")
	output
}
