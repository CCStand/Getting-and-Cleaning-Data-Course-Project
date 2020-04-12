#Function takes number and returns value at that number position in a list of values
num_to_val <- function(num, val){
  if(num > length(val)) {
    NA
  }
  else{
    val[num]
  }
}