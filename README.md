# dissertation-appendix

Dieses Projekt ist Bestandteil der Dissertation von Elisa Henke, vorgelegt an der Medizinischen Fakultät Carl Gustav Carus der Technischen Universität Dresden.

## Inhalt des Projektes ##

Das vorliegende Projekt enthält zusätzliche elektronische Anhänge der Dissertation von Elisa Henke mit dem Titel "_Harmonisierung und Verknüpfung klinischer Daten mit GKV-Routinedaten zur Förderung sektorenübergreifender Forschung_".

### Ordner 00_Generischer_Datenharmonisierungsprozess

Der Ordner enthält die Analysen und Ergebnisse der Literaturrecherche zur Konzeptionierung eines generischen Datenharmonisierungsprozesses für OMOP CDM (Kapitel 3).

Die Datei `Literaturrecherche.xlsx` beinhaltet die Ergebnisse der Literaturrecherche einschließlich der Ergebnisse des Title-Abstract-Screenings, des Volltext-Screenings, der Datenextraktion als auch der Bestimmung der zeitlichen Reihenfolge der Prozessschritte.

Das Skript `Häufigkeitsverteilung_Prozessschritte.ipynb` beinhaltet ein Jupyter Notebook zur Analyse der Häufigkeitsverteilung der identifizierten Prozessschritte.
Der Quellcode enthält die Visualisierung der Zuordnung der identifizierten Prozessschritte zu den eingeschlossenen Publikationen als Scatterplot in Kombination mit einem Histogramm zur Anzeige der Häufigkeit der Prozessschritte (Kapitel 3.2.3).
Die Visualiserung basiert auf den Ergebnissen der Literaturrecherche, welche über die Datei `Review_OMOP_process_python_prep.csv` im Quellcode eingelesen werden.
Der Quellcode ist in Anlehnung an die Visualisierung von Ines Reinecke implementiert wurden (inesreinecke. (2023). inesreinecke/dissertation-code: diss-release (diss). Zenodo. https://doi.org/10.5281/zenodo.8127650)).


### Ordner 01_Datensatzspezifikation

Die Datei `Datensatzspezifikation_GKV_Routinedaten.pdf` beinhaltet die Datensatzbeschreibung der vom Wissenschaftlichen Institut der AOK (WIdO) bereitgestellten Testdaten der GKV-Routinedaten.


### Ordner 02_Datenprofilierung

Die R-Skripte

* Verflachen_Condition_Ressourcen.R
* Verflachen_Encounter_Abteilungskontakt_Ressourcen.R
* Verflachen_Encounter_Einrichtungskontakt_Ressourcen.R
* Verflachen_Medication_Ressourcen.R
* Verflachen_MedicationAdministration_Ressourcen.R
* Verflachen_Observation_Ressourcen.R
* Verflachen_Patient_Ressourcen.R
* Verflachen_Procedure_Ressourcen.R

beinhalten das Verflachen von FHIR-Ressourcen, d.h. das Herunterladen von FHIR-Ressourcen im JSON-Format aus einem FHIR-Server und deren Überführung in eine tabellarische Struktur (Kapitel 4.2). 
Die Umsetzung erfolgte unter Anwednung des R-Paketes fhircrackr (Palm et al., 2023).

Die Dateien `ScanReport_klinische_Daten.xlsx` und `ScanReport_GKV_Routinedaten.xlsx` beinhalten die vom OHDSI Tool WhiteRabbit automatisch generierten Ergebnisse der Datenprofilierung klinischer Daten (Kapitel 5.2) und GKV-Routinedaten (Kapitel 6.2).


### Ordner 05_Vergleich

Die Datei `Vergleich_klinische_Daten_GKV_Routinedaten.xlsx` beinhaltet den Vergleich klinischer Daten mit GKV-Routinedaten auf den drei Ebenen _Domänen_, _Datenelemente_ und _Vokabulare_ (Kapitel 4.5 und 6.5).


### Ordner 06_Semantisches_Mapping

Die Datei `Vergleich_source_to_concept_map.xlsx` beinhaltet die Ergebnisse des Vergleichs der Zusatz-Mappings von der Autorin der vorliegenden Arbeit mit den Zusatz-Mappings existierender ETL-Prozesse von Zoch et al., 2022b und Lang, 2020 (Kapitel 4.6.3, 5.5.3 und 6.6.3).

Die Dateien `Ergebnisse_Vollständigkeit_missings_klinische_Daten.xlsx` und `Ergebnisse_Vollständigkeit_missings_GKV_Routinedaten` listen Kodes der Vokabulare der klinischen Daten und der GKV-Routinedaten auf, für welche im Rahmen der Evaluation der Vollständigkeit keine _concept_id_ in den aufbereiteten Vokabularen gefunden werden konnte (Kapitel 5.5.5 und 6.6.5).

Die Dateien `Ergebnisse_Korrektheit_invalid_klinische_Daten.xlsx` und `Ergebnisse_Korrektheit_invalid_GKV_Routinedaten` listen Kodes der Vokabulare inklusive Datumsangaben der klinischen Daten und der GKV-Routinedaten auf, deren Kombination im Rahmen der Evaluation der Korrektheit als invalid festgestellt wurden (Kapitel 5.5.5 und 6.6.5).


### Ordner 07_Strukturelles_Mapping

Die Dateien `Mapping_Dokumentation_GKV_OMOP_*.json.gz` und `Mapping_Dokumentation_GKV_OMOP_*.docx` beinhalten die Ergebnisse der mit dem OHDSI Tool RabbitInAHat erstellten strukturellen Mappings der GKV-Routinedaten (Kapitel 4.7 und 6.7) für die folgenden übergeordneten Entitäten:

* ambulante Arzneimittelverordnung
* ambulante Krankenhausversorgung
* Heilmittelversorgung
* Pflegeversicherung
* Stammdaten
* stationäre Krankenhausversorgung
* stationäre Rehabilitation
* vertragsärztliche Versorgung

Die Ergebnisse stehen als komprimierte JSON-Dateien zum erneuten Einlesen und Bearbeiten in RabbitInAHat sowie als Word-Dokumente zur Verfügung.


### Ordner 09_Qualitative_Datenqualitätsanalyse

Das SQL-Skript `Analyse_Fails_GKV_Routinedaten.sql` analysiert die in OMOP CDM harmonisierten GKV-Routinedaten zur Bestimmung der Gründe für nicht bestandene Datenqualitätsprüfungen inklusive der Ermittlung der zugehörigen Anzahl der betroffenen Datensätze (Kapitel 4.9 und 6.9). 

Die Datei `Ergebnisse_DQD_GKV_Routinedaten.xlsx` beinhaltet die Ergebnisse der qualitativen Datenqualitätsanalyse der in OMOP CDM harmonisierten GKV-Routinedaten mittels dem OHDSI Tool Data Quality Dashboard (DQD) sowie stellt die Gründe für nicht bestandene Prüfungen dar (Kapitel 4.9 und 6.9). 