# Definition of 'logistic' function
Logist.2.fun <- function(X, TCD50, Gamma50){
 1/(1+((TCD50/X)^(4*Gamma50)))
}


DRC.Logist.2 <- function(){
  fct <- function(x, parm) {
    Logist.2.fun(x, parm[,1], parm[,2])
  }
  ssfct <- function(data){
    # Get the data     
    x <- data[, 1]
    y <- data[, 2]
    
    a <- 0
    b <- 0
    start <- c(a,b)
    return(start)
  }
  names <- c("TCD50", "Gamma50")
  text <- "Logistic med physics model"
    
  ## Returning the function with self starter and names
  returnList <- list(fct = fct, ssfct = ssfct, names = names, text = text)
  class(returnList) <- "drcMean"
  invisible(returnList)
}
