# install fhircrackr R package
install.packages("fhircrackr")

# reference fhircrackr package
library(fhircrackr)

# set proxy
Sys.setenv(no_proxy="g09a004")

# define search URL for FHIR server
procedureRequest <- fhir_url(url="http://g09a004:28080/fhir", resource="Procedure")

# download FHIR Procedure resources from FHIR server
procedureBundles <- fhir_search(request = procedureRequest)

# define table description
pro_desc <- fhir_table_description(resource = "Procedure", brackets = c("[","]"), format = "wide")

# flatten FHIR Procedure resources
procedures <- fhir_crack(bundles = procedureBundles, design = pro_desc)

# display the tabulated FHIR Procedure resources
View(procedures)

# write results to a csv file
write.csv(x = procedures, file = "fhircrackr/procedures.csv", na="")
