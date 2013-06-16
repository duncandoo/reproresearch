library(xtable)

# Output counts of the categorical data
xout <- xtable(table(animalData$Animal, animalData$Color),
               caption="Pets and Color.\\label{tab:petColor}")
align(xout) <- "|l|l|l|l|l|"
print(xout, file="tex/petColor.tex")

