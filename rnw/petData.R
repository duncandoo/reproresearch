## @knitr petData
library(reshape2)
library(xtable)
Animal <- c(rep(0, 42), rep(1, 48))
Color <- c(rep(0, 15), rep(1, 20), rep(2, 30), rep(3, 25))
Animal <- factor(Animal, labels = c("Dog", "Cat"))
Color <- factor(Color, labels = c("Black", "Brown", "Yellow", "Gray"))
animalData <- data.frame(Animal, Color)
animalData$Height <- rnorm(90, 15, 10)
animalData$Weight <- rnorm(90, 18, 8)
prettyTable <- xtable(dcast(animalData, Animal~Color, value.var="Weight", fun.aggregate=length))
caption(prettyTable) <- "Number of each colour of pet by type"
label(prettyTable) <- "tab:petcolour"
