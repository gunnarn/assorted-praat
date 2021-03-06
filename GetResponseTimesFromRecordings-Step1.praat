# Get response times from sound files: Step 1 of 2
#
# Takes a set of sound files of recorded words, analyzes the duration of silent
# intervals and concatenates them into a long annotated sound. The results are used for 
# visually confirming and adjusting the accuracy of the automatic analysis. The resulting 
# text grid will be used to extract response times (the first silent segment of each recording.).
#
# Author: Gunnar Norrman (gunnar.norrman@biling.su.se)
#
# Instructions:
# 
# Import sound files to Praat and select them before running the script


@getSelected
@selectAll: "Sound"

# Create a long sound out of single recordings
Concatenate recoverably

# Select the newly created sound and rename it
selectObject: "Sound chain"
Rename: "Final"

# Select the new text grid with the tiles of the orignial sounds and rename it
selectObject: "TextGrid chain"
Rename: "originals"

# Select all orignial sounds and analyze silent and sounding intervals, the
# settings work well for my test sounds but may need to be tweaked for 
# other recordings
@selectAll: "Sound"
To TextGrid (silences): 100, 0.001, -50, 0.1, 0.1, "silent", "sounding"

# Create a long text grid of all the newly created text grids
@selectAll: "TextGrid"
Concatenate

# Append the new long text grid to the previous long text grid and rename
selectObject: "TextGrid originals"
plusObject: "TextGrid chain"
Merge
Rename: "Final"

# Remove all unused text grids
@selectAll: "TextGrid"
plusObject: "TextGrid originals"
plusObject: "TextGrid chain"
Remove

# Done!

procedure getSelected
	nObjects = numberOfSelected ()
	for i to nObjects
 		fullName$[i] = selected$ (i)
		name$[i] = extractLine$ (fullName$[i], " ")
	endfor

endproc

procedure selectAll: type$
	for i to nObjects
		if i == 1
			selectObject: type$ + " " + name$[i]
		else
			plusObject: type$ + " " + name$[i]
		endif
	endfor
endproc