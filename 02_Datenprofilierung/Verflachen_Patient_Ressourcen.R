# install fhircrackr R package
install.packages("fhircrackr")

# reference fhircrackr package
library(fhircrackr)

# set proxy
Sys.setenv(no_proxy="g09a004")

# define search URL for FHIR server
patientRequest <- fhir_url(url="http://g09a004:28080/fhir", resource="Patient")

# download FHIR Patient resources from FHIR server
patientBundles <- fhir_search(request = patientRequest)

# define table description
pat_desc <- fhir_table_description(resource = "Patient", brackets = c("[","]"), format = "wide")

# flatten FHIR Patient resources
patients <- fhir_crack(bundles = patientBundles, design = pat_desc)

# display the tabulated FHIR Patient resources
View(patients)

# write results to a csv file
write.csv(x = patients, file = "fhircrackr/patients.csv", na="")
