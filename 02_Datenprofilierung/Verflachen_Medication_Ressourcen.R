# install fhircrackr R package
install.packages("fhircrackr")

# reference fhircrackr package
library(fhircrackr)

# set proxy
Sys.setenv(no_proxy="g09a004")

# define search URL for FHIR server
medicationRequest <- fhir_url(url="http://g09a004:28080/fhir", resource="Medication")

# download FHIR Medication resources from FHIR server
medicationBundles <- fhir_search(request = medicationRequest)

# define table description
med_desc <- fhir_table_description(resource = "Medication", brackets = c("[","]"), format = "wide")

# flatten FHIR Medication resources
medications <- fhir_crack(bundles = medicationBundles, design = med_desc)

# display the tabulated FHIR Medication resources
View(medications)

# write results to a csv file
write.csv(x = medications, file = "fhircrackr/medications.csv", na="")
