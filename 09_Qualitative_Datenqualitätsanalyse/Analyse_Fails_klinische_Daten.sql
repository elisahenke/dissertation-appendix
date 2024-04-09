/*************************************************************************************************************************/
/* field_sourcevaluecompleteness_drug_exposure_drug_source_value */
/* The number and percent of distinct source values in the DRUG_SOURCE_VALUE field of the DRUG_EXPOSURE table mapped to 0. */

/*invalides Mapping von ATC-WHO zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.atc_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
drug_concept_zero AS
(
SELECT * FROM drug_exposure WHERE drug_concept_id = 0
)
SELECT COUNT(DISTINCT dz.drug_source_value)
FROM drug_concept_zero dz
JOIN standard_concat sc ON dz.drug_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat != '{null}';

/*kein Mapping von ATC-WHO zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.atc_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
drug_concept_zero AS
(
SELECT * FROM drug_exposure WHERE drug_concept_id = 0
)
SELECT COUNT(DISTINCT dz.drug_source_value)
FROM drug_concept_zero dz
JOIN standard_concat sc ON dz.drug_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat = '{null}';

/*ATC-GM Kodes*/
SELECT COUNT(DISTINCT d.drug_source_value) FROM drug_exposure d WHERE d.drug_concept_id = 0 and d.drug_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'ATC-GM');

/*Kodes unbekannter Herkunft*/
SELECT COUNT(DISTINCT d.drug_source_value) FROM drug_exposure d WHERE d.drug_concept_id = 0 and d.drug_source_concept_id NOT IN (SELECT concept_id FROM concept WHERE vocabulary_id IN ('ATC', 'ATC-GM'));

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_drug_exposure_drug_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field DRUG_CONCEPT_ID in the DRUG_EXPOSURE table. */

/*invalides Mapping von ATC-WHO zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.atc_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
drug_concept_zero AS
(
SELECT * FROM drug_exposure WHERE drug_concept_id = 0
)
SELECT COUNT(dz.*)
FROM drug_concept_zero dz
JOIN standard_concat sc ON dz.drug_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat != '{null}';

/*kein Mapping von ATC-WHO zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.atc_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
drug_concept_zero AS
(
SELECT * FROM drug_exposure WHERE drug_concept_id = 0
)
SELECT COUNT(dz.*)
FROM drug_concept_zero dz
JOIN standard_concat sc ON dz.drug_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat = '{null}';

/*ATC-GM Kodes*/
SELECT COUNT(*) FROM drug_exposure d WHERE d.drug_concept_id = 0 and d.drug_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'ATC-GM');

/*Kodes unbekannter Herkunft*/
SELECT COUNT(*) FROM drug_exposure d WHERE d.drug_concept_id = 0 and d.drug_source_concept_id NOT IN (SELECT concept_id FROM concept WHERE vocabulary_id IN ('ATC', 'ATC-GM'));

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_visit_detail_visit_detail_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field VISIT_DETAIL_CONCEPT_ID in the VISIT_DETAIL table. */

/*Suche der betroffenen Abteilungskontakte*/
SELECT vd.visit_detail_start_date, vd.visit_detail_end_date, vo.visit_source_value FROM visit_detail vd JOIN visit_occurrence vo ON vd.visit_occurrence_id = vo.visit_occurrence_id WHERE vd.visit_detail_concept_id = 0;

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_visit_occurrence_visit_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field VISIT_CONCEPT_ID in the VISIT_OCCURRENCE table. */

/*Suche der betroffenen Einrichtungskontakte*/
SELECT visit_source_value FROM visit_occurrence WHERE visit_concept_id = 0 ORDER BY visit_source_value ASC;

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_procedure_occurrence_procedure_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field PROCEDURE_CONCEPT_ID in the PROCEDURE_OCCURRENCE table. */

/*invalides Mapping von OPS zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.ops_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
procedure_concept_zero AS
(
SELECT * FROM procedure_occurrence WHERE procedure_concept_id = 0
)
SELECT COUNT(poz.*)
FROM procedure_concept_zero poz
JOIN standard_concat sc ON poz.procedure_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat != '{null}';

/*kein Mapping von OPS zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.ops_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
procedure_concept_zero AS
(
SELECT * FROM procedure_occurrence WHERE procedure_concept_id = 0
)
SELECT COUNT(poz.*)
FROM procedure_concept_zero poz
JOIN standard_concat sc ON poz.procedure_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat = '{null}';

/*invalides Mapping von ICD-10-GM zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.icd10gm_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
procedure_concept_zero AS
(
SELECT * FROM procedure_occurrence WHERE procedure_concept_id = 0
)
SELECT COUNT(poz.*)
FROM procedure_concept_zero poz
JOIN standard_concat sc ON poz.procedure_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat != '{null}';

/*kein Mapping von ICD-10-GM zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.icd10gm_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
procedure_concept_zero AS
(
SELECT * FROM procedure_occurrence WHERE procedure_concept_id = 0
)
SELECT COUNT(poz.*)
FROM procedure_concept_zero poz
JOIN standard_concat sc ON poz.procedure_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat = '{null}';

/*invalides Mapping von LOINC zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.loinc_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
procedure_concept_zero AS
(
SELECT * FROM procedure_occurrence WHERE procedure_concept_id = 0
)
SELECT COUNT(poz.*)
FROM procedure_concept_zero poz
JOIN standard_concat sc ON poz.procedure_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat != '{null}';

/*kein Mapping von LOINC zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.loinc_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
procedure_concept_zero AS
(
SELECT * FROM procedure_occurrence WHERE procedure_concept_id = 0
)
SELECT COUNT(poz.*)
FROM procedure_concept_zero poz
JOIN standard_concat sc ON poz.procedure_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat = '{null}';

/*Kodes unbekannter Herkunft*/
SELECT COUNT(*) FROM procedure_occurrence po WHERE po.procedure_concept_id = 0 and (po.procedure_source_concept_id NOT IN (SELECT concept_id FROM concept WHERE vocabulary_id IN ('OPS', 'ICD10GM', 'LOINC')));

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_condition_occurrence_condition_concept_id */
/*The number and percent of records with a value of 0 in the standard concept field CONDITION_CONCEPT_ID in the CONDITION_OCCURRENCE table.*/

/*invalides Mapping von ICD-10-GM zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.icd10gm_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
condition_concept_zero AS
(
SELECT * FROM condition_occurrence WHERE condition_concept_id = 0
)
SELECT COUNT(coz.*)
FROM condition_concept_zero coz
JOIN standard_concat sc ON coz.condition_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat != '{null}';

/*kein Mapping von ICD-10-GM zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.icd10gm_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
condition_concept_zero AS
(
SELECT * FROM condition_occurrence WHERE condition_concept_id = 0
)
SELECT COUNT(coz.*)
FROM condition_concept_zero coz
JOIN standard_concat sc ON coz.condition_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat = '{null}';

/*Kodes unbekannter Herkunft*/
SELECT COUNT(*) FROM condition_occurrence co WHERE co.condition_concept_id = 0 and (co.condition_source_concept_id NOT IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'ICD10GM'));

/*************************************************************************************************************************/
/* field_sourcevaluecompleteness_condition_occurrence_condition_source_value */
/* The number and percent of distinct source values in the CONDITION_SOURCE_VALUE field of the CONDITION_OCCURRENCE table mapped to 0. */

/*invalides Mapping von ICD-10-GM zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.icd10gm_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
condition_concept_zero AS
(
SELECT * FROM condition_occurrence WHERE condition_concept_id = 0
)
SELECT COUNT(DISTINCT coz.condition_source_value)
FROM condition_concept_zero coz
JOIN standard_concat sc ON coz.condition_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat != '{null}';

/*kein Mapping von ICD-10-GM zu Standard-Konzept*/
WITH standard_concat AS
(
SELECT source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date,
ARRAY_AGG (standard_concept_id || ';' || standard_domain_id || ';' || mapping_valid_start_date || ';' || mapping_valid_end_date) standard_concat
FROM cds_etl_helper.icd10gm_standard_lookup
GROUP BY (source_code, source_concept_id, source_domain_id, source_valid_start_date, source_valid_end_date)),
condition_concept_zero AS
(
SELECT * FROM condition_occurrence WHERE condition_concept_id = 0
)
SELECT COUNT(DISTINCT coz.condition_source_value)
FROM condition_concept_zero coz
JOIN standard_concat sc ON coz.condition_source_concept_id = sc.source_concept_id
WHERE sc.standard_concat = '{null}';

/*Kodes unbekannter Herkunft*/
SELECT COUNT(DISTINCT co.condition_source_value) FROM condition_occurrence co WHERE co.condition_concept_id = 0 and (co.condition_source_concept_id NOT IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'ICD10GM'));

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_measurement_unit_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field UNIT_CONCEPT_ID in the MEASUREMENT table. */

/*invalides Mapping von UCUM zu Standard-Konzept*/
SELECT COUNT(*) FROM measurement m JOIN cds_etl_helper.ucum_standard_lookup ucum ON m.unit_source_value = ucum.source_code WHERE m.unit_concept_id = 0 AND ucum.standard_concept_id != 0;

/*kein Mapping von UCUM zu Standard-Konzept*/
SELECT COUNT(*) FROM measurement m JOIN cds_etl_helper.ucum_standard_lookup ucum ON m.unit_source_value = ucum.source_code WHERE m.unit_concept_id = 0 AND ucum.standard_concept_id = 0;

/*Kodes unbekannter Herkunft*/
SELECT COUNT(*) FROM measurement m WHERE m.unit_concept_id = 0 AND m.unit_source_value NOT IN (SELECT concept_code FROM concept WHERE vocabulary_id = 'UCUM');

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_observation_unit_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field UNIT_CONCEPT_ID in the OBSERVATION table. */

/*invalides Mapping von UCUM zu Standard-Konzept*/
SELECT COUNT(*) FROM observation o JOIN cds_etl_helper.ucum_standard_lookup ucum ON o.unit_source_value = ucum.source_code WHERE o.unit_concept_id = 0 AND ucum.standard_concept_id != 0;

/*kein Mapping von UCUM zu Standard-Konzept*/
SELECT COUNT(*) FROM observation o JOIN cds_etl_helper.ucum_standard_lookup ucum ON o.unit_source_value = ucum.source_code WHERE o.unit_concept_id = 0 AND ucum.standard_concept_id = 0;

/*Kodes unbekannter Herkunft*/
SELECT COUNT(*) FROM observation o WHERE o.unit_concept_id = 0 AND o.unit_source_value NOT IN (SELECT concept_code FROM concept WHERE vocabulary_id = 'UCUM');