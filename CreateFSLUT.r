library(grDevices)

##########
#Parameters to set - hemisphere and column of interest and the path to the file.
#Instructions for using the outputs for display are provided at the bottom of the script.
##########
hemisphereParameter <- "lh"
asymOfInterest <- "Area"
Asym <- read.csv('vis_example.csv')

#color palette
palette <- colorRampPalette(c("blue","white", "red"))( 256 )

minExp <- min(Asym[,asymOfInterest])
maxExp <- max(Asym[,asymOfInterest])

#set colors
(Asym$normalizedAsym <- 1+ round(255* (Asym[,asymOfInterest] - minExp)/(maxExp-minExp)))
(Asym$hexColor <- palette[Asym$normalizedAsym ])
Asym$r <- col2rgb(Asym$hexColor)["red",]
Asym$g <- col2rgb(Asym$hexColor)["green",]
Asym$b <- col2rgb(Asym$hexColor)["blue",]
#set alpha to zero
Asym$a <- 0
(filename <- paste0(hemisphereParameter, "-", asymOfInterest, "-ColorLUT.txt"))

fileConn<-file(filename)
writeLines(c("#No. Label Name:                  R   G   B   A"), fileConn)
close(fileConn)

write.table( Asym[,c("annotationNumber", "Label.name", "r","g","b","a")], filename, quote=F, row.names=F, col.names=F, append=T)

print(paste0("Color lookup table written to: ",getwd(),"/", filename))
print(paste("Red is max score (", round(maxExp,digits=2),") red is min score (",round(minExp,digits=2) ,") and white is the midpoint"))


#instructions for loading file in tk surfer
#1. load tksurfer with desired hemisphere:
#      tksurfer fsaverage lh pial
#2. Then in tksurfer menubar go to File -->label(bottom of the menu) -> load label -> pick [l|r]h.aparc.annot file to show the DK atlas
#3. Then in go to File --> label(bottom of the menu) -> load color table -> pick custom made LUT file or use the command labl_load_color_table then the filename
#4. Click on "Save Multiple Views as TIFF" to create images (top right of button panel)
#5. Use CreateColorBar.R to create a color bar legends
