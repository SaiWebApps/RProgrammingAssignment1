## @param directory
##	Character vector of length 1 indicating the
##	location of the CSV files.
##
## @param threshold
##	Numeric vector of length 1 indicating the number of
##	completely observed observations (on all variables)
##	required to compute the correlation between sulfate
##	and nitrate. Default value is 0. 
##
## @return
##	A numeric vector of correlations.
corr <- function(directory, threshold = 0) {
	pollutantCorr <- numeric()

	# Retrieve a data frame delineating the number of complete
	# observations for each monitor id in directory.
	source("complete.R")
	nobsTable <- complete(directory)

	# Isolate the ids for which the number of complete observations
	# is strictly greater than the threshold.
	# Then, construct file paths for each of these filtered ids. 
	targetIds <- nobsTable[nobsTable[,"nobs"] > threshold, "id"]
	targetPaths <- file.path(directory, sprintf("%03d.csv", targetIds))

	# Read the files corresponding to the filtered ids.
	# For each file, calculate the correlation between complete (non-NA)
	# sulfate and nitrate observations. Add the correlation to the
	# pollutantCorr vector.
	for (filePath in targetPaths) {
		allInfo <- read.csv(filePath)
		completeCases <- allInfo[complete.cases(allInfo),]
		sulfate <- completeCases[,"sulfate"]
		nitrate <- completeCases[,"nitrate"]
		pollutantCorr <- c(pollutantCorr , cor(sulfate, nitrate))
	}

	pollutantCorr 
}
