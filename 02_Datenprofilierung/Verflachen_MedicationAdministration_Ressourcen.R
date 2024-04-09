# install fhircrackr R package
install.packages("fhircrackr")

# reference fhircrackr package
library(fhircrackr)

# set proxy
Sys.setenv(no_proxy="g09a004")

# define search URL for FHIR server
medicationAdministrationRequest <- fhir_url(url="http://g09a004:28080/fhir", resource="MedicationAdministration")

# download FHIR MedicationAdministration resources from FHIR server
medicationAdministrationBundles <- fhir_search(request = medicationAdministrationRequest)

# define table description
meda_desc <- fhir_table_description(resource = "MedicationAdministration", brackets = c("[","]"), format = "wide")

# flatten FHIR MedicationAdministration resources
medicationAdministrations <- fhir_crack(bundles = medicationAdministrationBundles, design = meda_desc)

# display the tabulated FHIR MedicationAdministration resources
View(medicationAdministrations)

# write results to a csv file
write.csv(x = medicationAdministrations, file = "fhircrackr/medicationAdministrations.csv", na="")
