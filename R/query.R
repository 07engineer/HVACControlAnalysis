#' query - SQL ODBC
#'
#' After setting up an open database connection (ODBC), this function calls the Transformative 
#' Wave server. Uses the ROBDC package.
#' 
#' @param site Site name string like "Altoona". Must have id entry inside function. 
#' @param start_date start date string like "09-01-2017"
#' @param end_date end date string like "09-01-2017"
#' @param variables comma separated string like str_c("eq_id", "Timestamp", "UnitKw", "OATemp", sep = ", ")
#' @param password the database password
#' @return A dataframe resulting from the SQL query
#' @keywords SQL
#' @export
#' @examples 
#' vars <- str_c("eq_id", "Timestamp", "UnitKw", "OATemp", sep = ", ")
#' data <- query("Altoona", "09-01-2017", "09-02-2017", vars) 
#' 


query <- function(site, start_date, end_date, variables, password){
  
  if(site == "East_Freedom"){ 
    id = "1356"
  }else if (site == "Claysburg") {
    id = "1355"
  } else if (site == "Altoona") {
    id = "1358"
  } else 
    stop("Site name incorrect, or needs to be associated with an id number")
  
  # Notice the single quotes to surround the date calls
  query_text <- str_c("Select ", variables, " From eq_min Where site_id = ", id, " and Timestamp >= '", start_date, "' and Timestamp < '", end_date,"' Order by Eq_id, Timestamp")
  
  myconn <- odbcConnect("Helix", uid="Helix", pwd= password)
  data <- sqlQuery(myconn, query_text)
  
  close(myconn)
  
  return(data)
}




