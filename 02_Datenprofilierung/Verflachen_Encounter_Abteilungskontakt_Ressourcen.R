# install fhircrackr R package
install.packages("fhircrackr")

# reference fhircrackr package
library(fhircrackr)

# set proxy
Sys.setenv(no_proxy="g09a004")

# define search URL for FHIR server
encounterRequest <- fhir_url(url="http://g09a004:28080/fhir", resource="Encounter", parameters = c("type" = "abteilungskontakt"))

# download FHIR Encounter resources from FHIR server
encounterBundles <- fhir_search(request = encounterRequest)

# define table description
enc_desc <- fhir_table_description(resource = "Encounter", brackets = c("[","]"), format = "wide")

# flatten FHIR Encounter resources
encounters <- fhir_crack(bundles = encounterBundles, design = enc_desc)

# display the tabulated FHIR Encounter resources
View(encounters)

# write results to a csv file
write.csv(x = encounters, file = "fhircrackr/encounterAK.csv", na="")
