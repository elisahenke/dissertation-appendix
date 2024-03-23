/*************************************************************************************************************************/
/* field_sourcevaluecompleteness_drug_exposure_drug_source_value */
/* The number and percent of distinct source values in the DRUG_SOURCE_VALUE field of the DRUG_EXPOSURE table mapped to 0. */

/*invalides Mapping von ATC-WHO zu Standard-Konzept*/
SELECT COUNT(DISTINCT d.drug_source_value) FROM drug_exposure d JOIN cds_etl_helper.atc_standard_concat atc ON d.drug_source_concept_id = atc.source_concept_id WHERE d.drug_concept_id = 0 AND atc.standard_concat != '{null}';

/*kein Mapping von ATC-WHO zu Standard-Konzept*/
SELECT COUNT(DISTINCT d.drug_source_value) FROM drug_exposure d JOIN cds_etl_helper.atc_standard_concat atc ON d.drug_source_concept_id = atc.source_concept_id WHERE d.drug_concept_id = 0 AND atc.standard_concat = '{null}';

/*ATC-GM Kodes*/
SELECT COUNT(DISTINCT d.drug_source_value) FROM drug_exposure d WHERE d.drug_concept_id = 0 and d.drug_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'ATC-GM');

/*Kodes unbekannter Herkunft*/
SELECT COUNT(DISTINCT d.drug_source_value) FROM drug_exposure d WHERE d.drug_concept_id = 0 and d.drug_source_concept_id NOT IN (SELECT concept_id FROM concept WHERE vocabulary_id IN ('ATC', 'ATC-GM'));

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_visit_detail_visit_detail_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field VISIT_DETAIL_CONCEPT_ID in the VISIT_DETAIL table. */

/*Suche der zugehörigen stationären Fälle in visit_occurrence*/
SELECT vd.*, vo.* FROM visit_detail vd JOIN visit_occurrence vo ON vd.visit_occurrence_id = vo.visit_occurrence_id WHERE vd.visit_detail_concept_id = 0;

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_visit_occurrence_visit_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field VISIT_CONCEPT_ID in the VISIT_OCCURRENCE table. */

/*Suche der Fälle in visit_occurrence*/
SELECT * FROM visit_occurrence WHERE visit_concept_id = 0;

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_drug_exposure_drug_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field DRUG_CONCEPT_ID in the DRUG_EXPOSURE table. */

/*invalides Mapping von ATC-WHO zu Standard-Konzept*/
SELECT COUNT(*) FROM drug_exposure d JOIN cds_etl_helper.atc_standard_concat atc ON d.drug_source_concept_id = atc.source_concept_id WHERE d.drug_concept_id = 0 AND atc.standard_concat != '{null}';

/*kein Mapping von ATC-WHO zu Standard-Konzept*/
SELECT COUNT(*) FROM drug_exposure d JOIN cds_etl_helper.atc_standard_concat atc ON d.drug_source_concept_id = atc.source_concept_id WHERE d.drug_concept_id = 0 AND atc.standard_concat = '{null}';

/*ATC-GM Kodes*/
SELECT COUNT(*) FROM drug_exposure d WHERE d.drug_concept_id = 0 and d.drug_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'ATC-GM');

/*Kodes unbekannter Herkunft*/
SELECT COUNT(*) FROM drug_exposure d WHERE d.drug_concept_id = 0 and d.drug_source_concept_id NOT IN (SELECT concept_id FROM concept WHERE vocabulary_id IN ('ATC', 'ATC-GM'));

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_procedure_occurrence_procedure_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field PROCEDURE_CONCEPT_ID in the PROCEDURE_OCCURRENCE table. */

/*invalides Mapping von OPS zu Standard-Konzept*/
SELECT COUNT(*) FROM procedure_occurrence po JOIN cds_etl_helper.ops_standard_concat ops ON po.procedure_source_concept_id = ops.source_concept_id WHERE po.procedure_concept_id = 0 AND ops.standard_concat != '{null}';

/*kein Mapping von OPS zu Standard-Konzept*/
SELECT COUNT(*) FROM procedure_occurrence po JOIN cds_etl_helper.ops_standard_concat ops ON po.procedure_source_concept_id = ops.source_concept_id WHERE po.procedure_concept_id = 0 AND ops.standard_concat = '{null}';

/*PIA Kodes*/
SELECT COUNT(*) FROM procedure_occurrence po WHERE po.procedure_concept_id = 0 and po.procedure_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'PIA');

/*invalides Mapping von ICD-10-GM zu Standard-Konzept*/
SELECT COUNT(*) FROM procedure_occurrence po JOIN cds_etl_helper.icd10gm_standard_concat icd ON po.procedure_source_concept_id = icd.source_concept_id WHERE po.procedure_concept_id = 0 AND icd.standard_concat != '{null}';

/*kein Mapping von ICD-10-GM zu Standard-Konzept*/
SELECT COUNT(*) FROM procedure_occurrence po JOIN cds_etl_helper.icd10gm_standard_concat icd ON po.procedure_source_concept_id = icd.source_concept_id WHERE po.procedure_concept_id = 0 AND icd.standard_concat = '{null}';

/*HPNR Kodes*/
SELECT COUNT(*) FROM procedure_occurrence po WHERE po.procedure_concept_id = 0 and po.procedure_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'HPNR');

/*ASV Kodes*/
SELECT COUNT(*) FROM procedure_occurrence po WHERE po.procedure_concept_id = 0 and po.procedure_source_value IN (SELECT source_code FROM source_to_concept_map WHERE source_vocabulary_id = 'ASV');

/*Kodes unbekannter Herkunft*/
SELECT COUNT(*) FROM procedure_occurrence po WHERE po.procedure_concept_id = 0 and (po.procedure_source_concept_id NOT IN (SELECT concept_id FROM concept WHERE vocabulary_id IN ('OPS', 'ICD10GM', 'HPNR', 'PIA'))) and (po.procedure_source_value NOT IN (SELECT source_code FROM source_to_concept_map WHERE source_vocabulary_id = 'ASV'));

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_condition_occurrence_condition_concept_id */
/*The number and percent of records with a value of 0 in the standard concept field CONDITION_CONCEPT_ID in the CONDITION_OCCURRENCE table.*/

/*invalides Mapping von ICD-10-GM zu Standard-Konzept*/
SELECT COUNT(*) FROM condition_occurrence co JOIN cds_etl_helper.icd10gm_standard_concat icd ON co.condition_source_concept_id = icd.source_concept_id WHERE co.condition_concept_id = 0 AND icd.standard_concat != '{null}';

/*kein Mapping von ICD-10-GM zu Standard-Konzept*/
SELECT COUNT(*) FROM condition_occurrence co JOIN cds_etl_helper.icd10gm_standard_concat icd ON co.condition_source_concept_id = icd.source_concept_id WHERE co.condition_concept_id = 0 AND icd.standard_concat = '{null}';

/*HMK Kodes*/
SELECT COUNT(*) FROM condition_occurrence co WHERE co.condition_concept_id = 0 and co.condition_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'HMK');

/*ASV Kodes*/
SELECT COUNT(*) FROM condition_occurrence co WHERE co.condition_concept_id = 0 and co.condition_source_value IN (SELECT source_code FROM source_to_concept_map WHERE source_vocabulary_id = 'ASV');

/*Kodes unbekannter Herkunft*/
SELECT COUNT(*) FROM condition_occurrence co WHERE co.condition_concept_id = 0 and (co.condition_source_concept_id NOT IN (SELECT concept_id FROM concept WHERE vocabulary_id IN ('ICD10GM', 'HMK'))) and (co.condition_source_value NOT IN (SELECT source_code FROM source_to_concept_map WHERE source_vocabulary_id = 'ASV'));

/*************************************************************************************************************************/
/* field_sourcevaluecompleteness_condition_occurrence_condition_source_value */
/* The number and percent of distinct source values in the CONDITION_SOURCE_VALUE field of the CONDITION_OCCURRENCE table mapped to 0. */

/*invalides Mapping von ICD-10-GM zu Standard-Konzept*/
SELECT COUNT(DISTINCT co.condition_source_value) FROM condition_occurrence co JOIN cds_etl_helper.icd10gm_standard_concat icd ON co.condition_source_concept_id = icd.source_concept_id WHERE co.condition_concept_id = 0 AND icd.standard_concat != '{null}';

/*kein Mapping von ICD-10-GM zu Standard-Konzept*/
SELECT COUNT(DISTINCT co.condition_source_value) FROM condition_occurrence co JOIN cds_etl_helper.icd10gm_standard_concat icd ON co.condition_source_concept_id = icd.source_concept_id WHERE co.condition_concept_id = 0 AND icd.standard_concat = '{null}';

/*HMK Kodes*/
SELECT COUNT(DISTINCT co.condition_source_value) FROM condition_occurrence co WHERE co.condition_concept_id = 0 and co.condition_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'HMK');

/*Kodes unbekannter Herkunft*/
SELECT COUNT(DISTINCT co.condition_source_value) FROM condition_occurrence co WHERE co.condition_concept_id = 0 and (co.condition_source_concept_id NOT IN (SELECT concept_id FROM concept WHERE vocabulary_id IN ('ICD10GM', 'HMK'))) and (co.condition_source_value NOT IN (SELECT source_code FROM source_to_concept_map WHERE source_vocabulary_id = 'ASV'));

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_measurement_measurement_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field MEASUREMENT_CONCEPT_ID in the MEASUREMENT table. */

/*invalides Mapping von ICD-10-GM zu Standard-Konzept*/
SELECT COUNT(*) FROM measurement m JOIN cds_etl_helper.icd10gm_standard_concat icd ON m.measurement_source_concept_id = icd.source_concept_id WHERE m.measurement_concept_id = 0 AND icd.standard_concat != '{null}';

/*************************************************************************************************************************/
/* field_standardconceptrecordcompleteness_observation_observation_concept_id */
/* The number and percent of records with a value of 0 in the standard concept field OBSERVATION_CONCEPT_ID in the OBSERVATION table. */

/*invalides Mapping von ICD-10-GM zu Standard-Konzept*/
SELECT COUNT(*) FROM observation o JOIN cds_etl_helper.icd10gm_standard_concat icd ON o.observation_source_concept_id = icd.source_concept_id WHERE o.observation_concept_id = 0 AND icd.standard_concat != '{null}';

/*kein Mapping von ICD-10-GM zu Standard-Konzept*/
SELECT COUNT(*) FROM observation o JOIN cds_etl_helper.icd10gm_standard_concat icd ON o.observation_source_concept_id = icd.source_concept_id WHERE o.observation_concept_id = 0 AND icd.standard_concat = '{null}';

/*invalides Mapping von OPS zu Standard-Konzept*/
SELECT COUNT(*) FROM observation o JOIN cds_etl_helper.ops_standard_concat ops ON o.observation_source_concept_id = ops.source_concept_id WHERE o.observation_concept_id = 0 AND ops.standard_concat != '{null}';

/*kein Mapping von OPS zu Standard-Konzept*/
SELECT COUNT(*) FROM observation o JOIN cds_etl_helper.ops_standard_concat ops ON o.observation_source_concept_id = ops.source_concept_id WHERE o.observation_concept_id = 0 AND ops.standard_concat = '{null}';

/*HPNR Kodes*/
SELECT COUNT(*) FROM observation o WHERE o.observation_concept_id = 0 and o.observation_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'HPNR');

/*EBM Kodes*/
SELECT COUNT(*) FROM observation o WHERE o.observation_concept_id = 0 and o.observation_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'EBM');

/*Stationäre Entgeltarten Kodes*/
SELECT COUNT(*) FROM observation o WHERE o.observation_concept_id = 0 and o.observation_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'Inpatient charge');

/*Ambulante Entgeltarten Kodes*/
SELECT COUNT(*) FROM observation o WHERE o.observation_concept_id = 0 and o.observation_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'Outpatient charge');

/*Behandlungsart Kodes*/
SELECT COUNT(*) FROM observation o WHERE o.observation_concept_id = 0 and o.observation_source_concept_id IN (SELECT concept_id FROM concept WHERE vocabulary_id = 'Rehabilitation type');

/*ASV Kodes*/
SELECT COUNT(*) FROM observation o WHERE o.observation_concept_id = 0 and o.observation_source_value IN (SELECT source_code FROM source_to_concept_map WHERE source_vocabulary_id = 'ASV' AND target_concept_id = 0);

/*Entlassungsgrund Kodes*/
SELECT COUNT(*) FROM observation o WHERE o.observation_concept_id = 0 and 
(o.observation_source_value IN (SELECT source_code FROM source_to_concept_map WHERE source_vocabulary_id = 'Discharge Reason' AND target_concept_id = 0) 
or o.qualifier_concept_id IN (4053230, 4052193, 36210399));

/*Art der ambulanten Behandlung Kodes*/
SELECT COUNT(*) FROM observation o WHERE o.observation_concept_id = 0 and o.observation_source_value IN (SELECT source_code FROM source_to_concept_map WHERE source_vocabulary_id = 'Visit Type AMB' AND target_concept_id = 0);

/*Pflegestufe Kodes*/
SELECT COUNT(*) FROM observation o WHERE o.observation_concept_id = 0 and o.observation_source_value IN (SELECT source_code FROM source_to_concept_map WHERE source_vocabulary_id = 'Nursing Stage' AND target_concept_id = 0);

/*PEA Pflegedaten*/
SELECT COUNT(*) FROM observation o WHERE o.observation_concept_id = 0 and o.observation_source_value  = 'PEA';

/*Kodes unbekannter Herkunft*/
SELECT COUNT(*) FROM observation o WHERE o.observation_concept_id = 0 
and (o.observation_source_concept_id NOT IN (SELECT concept_id FROM concept WHERE vocabulary_id IN ('ICD10GM', 'OPS', 'HPNR', 'EBM', 'Inpatient charge', 'Outpatient charge', 'Rehabilitation type'))
or observation_source_concept_id IS NULL) 
and (o.observation_source_value NOT IN (SELECT source_code FROM source_to_concept_map WHERE source_vocabulary_id IN ('ASV', 'Discharge Reason', 'Visit Type AMB', 'Nursing Stage') and target_concept_id = 0)) 
and o.observation_source_value != 'PEA' 
and o.qualifier_concept_id IS NULL;
