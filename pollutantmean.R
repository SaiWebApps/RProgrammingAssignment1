## @param directory
##	Character vector of length 1 indicating the
##	location of the CSV files.
##
## @param pollutant
##	Character vector of length 1 indicating the
##	name of the pollutant for which we will calculate
##	the mean; either "sulfate" or "nitrate".
##
## @param id
##	Integer vector indicating monitor id numbers to be used.
##	Default value is 1:332 (seq_len(332)).
##
## @return
##	The mean of the pollutant across all monitors listed in
##	the id vector (ignoring NA values).
pollutantmean <- function(directory, pollutant, id = 1:332) {
	pollutantInfo <- numeric()

	inputFilePaths <- file.path(directory, sprintf("%03d.csv", id))
	for (infile in inputFilePaths) {
		allInfo <- read.csv(infile)
		nonNARows <- !is.na(allInfo[,pollutant])
		pollutantInfoForNonNARows <- allInfo[nonNARows, pollutant]
		pollutantInfo <- c(pollutantInfo, pollutantInfoForNonNARows)
	}

	mean(pollutantInfo)
}
