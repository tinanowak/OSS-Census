# Required library
library(httr)
library(jsonlite)

# Function to query the GitHub API with an email address and return the username
get_username <- function(email) {
  response <- GET(
    url = paste0("https://api.github.com/search/users?q=", email),
    add_headers("Accept" = "application/vnd.github+json")
  )
  
  # Check the status of the API request
  if (response$status_code == 200) {
    # Parse the JSON response
    json_response <- content(response, "parsed")
    
    # Check if the response contains any items
    if (json_response$total_count > 0) {
      # Return the first username found
      return(json_response$items[[1]]$login)
    } else {
      # Return NA if no username is found
      return(NA)
    }
  } else {
    # Return NA if the API request fails
    return(NA)
  }
}

# List of emails
emails <- c("email1@example.com", "email2@example.com", "email3@example.com")

# Use the function to get the username for each email
usernames <- sapply(emails, get_username)

# Print the resulting username list
print(usernames)

# Write the results to a CSV file
write.csv(data.frame(emails, usernames), file = "email_username_match.csv", row.names = FALSE)
