# install fhircrackr R package
install.packages("fhircrackr")

# reference fhircrackr package
library(fhircrackr)

# set proxy
Sys.setenv(no_proxy="g09a004")

# define search URL for FHIR server
conditionRequest <- fhir_url(url="http://g09a004:28080/fhir", resource="Condition")

# download FHIR Condition resources from FHIR server
conditionBundles <- fhir_search(request = conditionRequest)

# define table description
con_desc <- fhir_table_description(resource = "Condition", brackets = c("[","]"), format = "wide")

# flatten FHIR Condition resources
conditions <- fhir_crack(bundles = conditionBundles, design = con_desc)

# display the tabulated FHIR Condition resources
View(conditions)

# write results to a csv file
write.csv(x = conditions, file = "fhircrackr/conditions.csv", na="")
