
# Synthetic Clinical Datasets

This folder contains synthetic clinical datasets developed to support demonstration, training, and analytical pipeline development within the ISARIC VERTEX platform.

## Purpose

The datasets provide realistic clinical data compatible with the platform structure, allowing analysts to develop, test, and familiarise themselves with analytical workflows while real-world data collection is ongoing.

These datasets are intended for software development, methodological training, and demonstration purposes. They are not intended for clinical inference, predictive model validation, or the generation of substantive research findings.

## Synthetic Data Generation

The synthetic data generation approach was developed and evaluated using the ISARIC COVID-19 cohort, comprising 945,316 hospitalised patients from 75 countries and approximately 1,500 clinical centres.

The development focused on the United Kingdom and South African cohorts, which represented approximately 85% of the registry and exhibited systematic differences in data collection.

Two synthetic data generation approaches were implemented using DataCebo:

- Gaussian Copula
- Conditional Tabular Generative Adversarial Network (CTGAN)

Synthetic datasets were generated separately for each national cohort to preserve differences in data collection before harmonisation during post-processing.

To reproduce realistic missingness, patterns of data availability were characterised and clustered using binary indicators of observed and missing values. These patterns were subsequently reintroduced proportionally into the generated datasets.

### Evaluation

The synthetic datasets were compared with their corresponding source cohorts to assess the preservation of key statistical properties, including:

- Demographic distributions (age and sex)
- Clinical symptom distributions
- Clinical outcome distributions
- Age- and sex-stratified outcome distributions
- Structure and relative frequency of missingness patterns

The resulting datasets approximated these characteristics while retaining differences in data availability between the two national cohorts.

The generation pipeline produced 150,000 synthetic UK patient records and 150,000 synthetic South African patient records.

Formal statistical equivalence and preservation of all multivariable clinical associations were not established.

## Files

- `data_dict.csv`: Data dictionary describing the dataset variables.
- `data_synth.csv`: Synthetic clinical dataset.
- `data_synth_discharge_platelets.csv`: Additional synthetic dataset for testing analytical workflows.

## Usage

The datasets can be used to explore and test analytical functionality within the [ISARIC VERTEX platform](https://vertex.isaric.org/?project=archetypecrf-h5nx-synthetic).

Synthetic data support:

- Demonstration of platform functionality
- Training and familiarisation with analytical tools
- Development and testing of analytical pipelines
- Preparation of analytical workflows while real-world data collection is ongoing

## Limitations

Although synthetic datasets reproduce selected statistical properties of clinical data, they are not guaranteed to preserve all multivariable relationships, rare events, or underlying clinical associations.

The datasets are not intended to replace real clinical data for statistical inference, predictive model validation, or clinical decision-making.

Analytical pipelines developed using synthetic data should be tested using appropriate real-world data before being used for research.

## Acknowledgements

The synthetic data generation approach was developed within the International Severe Acute Respiratory and emerging Infection Consortium (ISARIC).

Development and evaluation: F. Xu, T. Edinburgh, and E. Garcia-Gallo.
