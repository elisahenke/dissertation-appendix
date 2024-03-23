# install fhircrackr R package
install.packages("fhircrackr")

# reference fhircrackr package
library(fhircrackr)

# set proxy
Sys.setenv(no_proxy="g09a004")

# define search URL for FHIR server
observationRequest <- fhir_url(url="http://g09a004:28080/fhir", resource="Observation")

# download FHIR Observation resources from FHIR server
observationBundles <- fhir_search(request = observationRequest)

# define table description
obs_desc <- fhir_table_description(resource = "Observation", brackets = c("[","]"), format = "wide")

# flatten FHIR Observation resources
observations <- fhir_crack(bundles = observationBundles, design = obs_desc)

# display the tabulated FHIR Observation resources
View(observations)

# write results to a csv file
write.csv(x = observations, file = "fhircrackr/observations.csv", na="")
