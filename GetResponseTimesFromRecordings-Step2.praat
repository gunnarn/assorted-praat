# Get response times from sound files: Step 2 of 2
#
# Takes a dual tier text grid object (from Step 1) with the names of separate recordings in tier 1
# and the analyzed recordings in tier 2. Extracts the duration of the first silent
# interval of each sound and adds it to a table together with the sound name. THe table
# can be saved as a csv file.
#
# Author: Gunnar Norrman (gunnar.norrman@biling.su.se)
#
# Instructions:
# 
# Before running, run step 1 and select the long text grid "TextGrid Final"


@getSelected

# Get the number of original files in the long text grid
nIntervals = Get number of intervals: 1

# Create a table to store results
resultsTable = Create Table with column names: "results", 0, "filename rt"

# Loop over all originql sounds
for n to nIntervals

	selectObject: fullName$[1]

	intervalName$ = Get label of interval: 1, n
	intervalStart = Get start time of interval: 1, n
	intervalEnd = Get end time of interval: 1, n

	newPart = Extract part: intervalStart, intervalEnd, "yes"

	# Get duration of the first silend segment
	selectObject: newPart
	startingPoints = Get starting points: 2, "is equal to", "silent"
	startTime = Get time from index: 1
	selectObject: newPart
	endPoints = Get end points: 2, "is equal to", "silent"
	endTime = Get time from index: 1
	duration = endTime - startTime
	
	# Append to table
	selectObject: resultsTable
	Append row
	Set string value: n, "filename", intervalName$
	Set numeric value: n, "rt", duration

	removeObject: startingPoints, endPoints, newPart
	
endfor

# Done!


### Procedures

procedure getSelected
	nObjects = numberOfSelected ()
	for i to nObjects
 		fullName$[i] = selected$ (i)
		name$[i] = extractLine$ (fullName$[i], " ")
	endfor
endproc