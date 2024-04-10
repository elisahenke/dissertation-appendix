/*************************************************************************************************************************/
/* FHIR Profil Procedure*/
SELECT COUNT(DISTINCT fhir_logical_id) FROM person;

/*************************************************************************************************************************/
/* FHIR Profil Encounter (Einrichtungskontakt)*/
SELECT COUNT(DISTINCT fhir_logical_id) FROM visit_occurrence;

/*************************************************************************************************************************/
/* FHIR Profil Encounter (Abteilungskontakt)*/
SELECT COUNT(DISTINCT fhir_logical_id) FROM visit_detail;

/*************************************************************************************************************************/
/* FHIR Profil Medication*/
SELECT COUNT(DISTINCT fhir_logical_id) FROM cds_etl_helper.medication_id_map;

/*************************************************************************************************************************/
/* FHIR Profil Procedure*/
WITH sub_procedure AS(
SELECT DISTINCT po.fhir_logical_id FROM procedure_occurrence po WHERE po.fhir_logical_id LIKE 'pro-%'),
sub_drug AS(
SELECT DISTINCT de.fhir_logical_id FROM drug_exposure de WHERE de.fhir_logical_id LIKE 'pro-%'),
sub_measurement AS(
SELECT DISTINCT m.fhir_logical_id FROM measurement m WHERE m.fhir_logical_id LIKE 'pro-%'),
sub_observation AS(
SELECT DISTINCT o.fhir_logical_id FROM observation o WHERE o.fhir_logical_id LIKE 'pro-%')
SELECT sp.fhir_logical_id FROM sub_procedure sp
UNION
SELECT sd.fhir_logical_id FROM sub_drug sd
UNION
SELECT sm.fhir_logical_id FROM sub_measurement sm
UNION
SELECT so.fhir_logical_id FROM sub_observation so;

/*************************************************************************************************************************/
/* FHIR Profil MedicationAdministration*/
WITH sub_drug AS(
SELECT DISTINCT de.fhir_logical_id FROM drug_exposure de WHERE de.fhir_logical_id LIKE 'mea-%'),
sub_observation AS(
SELECT DISTINCT o.fhir_logical_id FROM observation o WHERE o.fhir_logical_id LIKE 'mea-%')
SELECT sd.fhir_logical_id FROM sub_drug sd
UNION
SELECT so.fhir_logical_id FROM sub_observation so;

/*************************************************************************************************************************/
/* FHIR Profil Observation*/
WITH sub_procedure AS(
SELECT DISTINCT po.fhir_logical_id FROM procedure_occurrence po WHERE po.fhir_logical_id LIKE 'obs-%'),
sub_measurement AS(
SELECT DISTINCT m.fhir_logical_id FROM measurement m WHERE m.fhir_logical_id LIKE 'obs-%'),
sub_observation AS(
SELECT DISTINCT o.fhir_logical_id FROM observation o WHERE o.fhir_logical_id LIKE 'obs-%')
SELECT sp.fhir_logical_id FROM sub_procedure sp
UNION
SELECT sm.fhir_logical_id FROM sub_measurement sm
UNION
SELECT so.fhir_logical_id FROM sub_observation so;

/*************************************************************************************************************************/
/* FHIR Profil Condition*/
WITH sub_condition AS(
SELECT DISTINCT co.fhir_logical_id FROM condition_occurrence co WHERE co.fhir_logical_id LIKE 'con-%'),
sub_procedure AS(
SELECT DISTINCT po.fhir_logical_id FROM procedure_occurrence po WHERE po.fhir_logical_id LIKE 'con-%'),
sub_measurement AS(
SELECT DISTINCT m.fhir_logical_id FROM measurement m WHERE m.fhir_logical_id LIKE 'con-%'),
sub_observation AS(
SELECT DISTINCT o.fhir_logical_id FROM observation o WHERE o.fhir_logical_id LIKE 'con-%' AND (o.value_as_string IS NULL OR o.value_as_string NOT IN ('L', 'R', 'B')))
SELECT sc.fhir_logical_id FROM sub_condition sc
UNION
SELECT sp.fhir_logical_id FROM sub_procedure sp
UNION
SELECT sm.fhir_logical_id FROM sub_measurement sm
UNION
SELECT so.fhir_logical_id FROM sub_observation so;