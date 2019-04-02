add_parent <- function(x, multiplier, no_digits)
{
  percent <- round(x * multiplier, digits = no_digits)
  result <- paste(percent, "%", sep = " ")
  # Return the calculation. Note this is optional
  # since R returns the value of the last line of code
  return(result)
}

sample_vector <- c(0.458, 1.6653, 0.83112)

updated_vector <- add_parent(sample_vector, 1, 5)
updated_vector

price_calculator <- function(hourly_value, pph= 40){
  # Calculate charges as hourly rate x price per hour
  net_price <- hourly_value * pph
  if (hourly_value >100){
    net_price <- net_price * .9
  }
  
  return(net_price)
}

price_calculator(hourly_value = 110)

price_calculator <- function(hourly_value, pph=40, status){
  
  net_price <- hourly_value * pph
  if (hourly_value >100){
    net_price <- net_price * .9
  }
  if (status == 'public'){
    net_price <- net_price * 1.06
  }
  else if(status == 'private'){
    net_price <- net_price * 1.12
  }
  return(net_price)
}

price_calculator(200,status = 'private')
