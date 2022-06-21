README
================
June, 2022

[Background](#Background)  
[About this repository](#AboutthisRepository)  
[Prerequisite](#Prerequisite)  
[About the data](#Data)  
[Contributors](#Contributors)  
[License](#License)  
[Contact](#Contact)  
[Disclaimer](#Disclaimer)

# SARS-ANI: A Global Open Access Dataset of Reported SARS-CoV-2 Events in Animals

## Background <a name="Background"></a>

The severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2) most
probably emerged from an animal source and subsequently spilled over to
the human population in 2019, in China. Despite its zoonotic origin, the
current COVID-19 pandemic is being sustained through human-to-human
transmission. <br>

Animal infections with SARS-CoV-2 have been reported by several
countries. A wide range of animal species have proven to be susceptible
to SARS-CoV-2 either via natural and/or experimental infection. <br>

Collecting and sharing data on reported SARS-CoV-2 natural infections in
animals is of critical importance to assess their epidemiological
significance for animal and human health, as well as their implications
for biodiversity and conservation. <br>

## About this repository <a name="AboutthisRepository"></a>

This is the public repository of the SARS-ANI Dataset and related
documentation. <br>

This repository contains: <br>

**<code>sars_ani_data.csv</code>**: This file contains the **raw data**
of the SARS-ANI Dataset, which presents structured information on
SARS-CoV-2 events in animals (.csv format, UTF-8 encoded). <br>

**<code>sars_ani_validation.R</code>**: This file contains the **code**
to validate and curate the dataset. This code enables the users to
explore the structure of the dataset, check the different entries for
each field, and search for the presence of duplicates. <br>

**<code>sars_ani_visualization.Rmd</code>**: This Markdown file contains
the **code** to explore, describe, and visualize the dataset. This code
is used for the visual validation of the data. To see all the results,
knit it to .pdf (default output). <br>

Explanations for the code are displayed in the .R and .Rmd files.<br>

**<code>sars_ani_examples.pdf</code>**: This PDF file contains three
examples illustrating the structure and coding scheme of the SARS-ANI
Dataset.<br>

**<code>Contributing.md</code>**: This file provides guidelines for
contributing to the project: suggesting changes to the data or to the
code, submitting new data, and contributing to the code.<br>

**<code>sars_ani_PDF_archives</code>**: For each SARS-CoV-2 event
recorded in the dataset, a copy of the report used as primary and
secondary information source is saved in this folder. Each report was
downloaded as a .pdf file, on which a timestamp was inserted
(ProMED-mail reports) or the download date was added to the file name
(it was not possible to insert a timestamp on WAHIS reports). <br>  
**<code>sars_ani_excluded_rep.xlsx</code>**: This file contains the list
of ProMED-mail and WAHIS reports that were not included in the dataset
and reasons for exclusion. <br>

The [SARS-ANI Dashboard](https://vis.csh.ac.at/sars-ani) provides
interactive visualizations of the dynamic version of the dataset. <br>

**The data on this repository is weekly updated.**

## Prerequisite <a name="Prerequisite"></a>

#### Install LaTeX (TinyTeX) for PDF reports

If you would like to create PDF documents from R Markdown, you will need
to have a LaTeX distribution installed. <br>  
To install TinyTeX with the R package tinytex, run the following code in
the Console: <code>tinytex::install_tinytex()</code> <br>

To uninstall TinyTeX, run: <code>tinytex::uninstall_tinytex()</code>

#### Environment

The dataset and code were created in an English-typing environment,
where the <code>.</code> is used as the decimal symbol and dates are in
the format <code>yyyy-mm-dd</code>. <br>

To know more about local environment, see:
<https://cran.r-project.org/web/packages/readr/vignettes/locales.html>.

## About the Data <a name="Data"></a>

### Data sources

Information has been collected from two major databases: i) the Program
for Monitoring Emerging Diseases [ProMED-mail](https://promedmail.org/),
which is a program of the International Society for Infectious Diseases
([ISID](https://isid.org/)); ii) the World Animal Health Information
System [WAHIS](https://wahis.woah.org/) of the World Organisation for
Animal Health ([WOAH](https://wahis.woah.org/#/home), formerly OIE).
<br>

[ProMED-mail](https://promedmail.org/) is the largest publicly available
system reporting of global infectious disease outbreaks. It provides
reports (called “posts”) on outbreaks and disease emergence. The
information flow leading to publication of ProMED-mail reports is as
follows: a disease event to be dispatched is selected from daily
notifications of outbreaks received via emails, searching through the
Internet and traditional media, and scanning of official and unofficial
websites. All incoming information is reviewed and filtered by an editor
or associate editor who, subsequently sends them to a multidisciplinary
global team of subject matter expert moderators who assess the
accountability and accuracy of the information, interpret it, provide
commentary, and give references to previous ProMED-mail reports and to
the scientific literature. <br>

[WAHIS](https://wahis.woah.org/) is a Web-based computer system that
processes data on animal diseases in real-time. WAHIS data reflects the
information gathered by the Veterinary Services from WOAH Members and
non-Members Countries and Territories on WOAH-listed diseases in
domestic animals and wildlife, as well as on emerging and zoonotic
diseases. The detection of infection with SARS-CoV-2 in animals meets
the criteria for reporting to the World Animal Health Organisation
(WOAH) as an emerging infection in accordance with the WOAH Terrestrial
Animal Health Code. Only authorized users, i.e. the Delegates of WOAH
Member Countries and their authorised representatives, can enter data
into the WAHIS platform to notify the WOAH of relevant animal disease
information. All information are publicly accessible on the
[WAHIS](https://wahis.woah.org/#/events) interface. <br>

One ProMED-mail or WAHIS report, identified via a unique report
identifier, may depict one single or several health events (or
outbreaks). ProMED-mail and WAHIS also publish follow-up reports of
outbreaks (describing e.g. clinical follow-up, further spread of the
virus, treatment outcome, number of newly infected animals and new
deaths, newly implemented control measures) that have also been entered
in the dataset. <br>

### Remarks

The number of reported SARS-CoV-2 events in animals in each country
depends on the reporting strategy of the country to the WOAH, the
intensity of the research and surveillance strategy in the different
animal species (e.g. whether pets from infected households are
systematically investigated or not), the media coverage on the diagnosed
cases, and the uptake of the reported event by the ProMED-mail team. If
an event/outbreak is not published in WAHIS and/or ProMED-mail then it
will not be included in the dataset.<br>

### Data collection process

Data on each SARS-CoV-2 event in animals was collected and entered
manually in a .csv file. <br>

### Data records

The dataset is structured such as: <br>

-   Each **row** of the dataset represents a SARS-CoV-2 event in
    animal(s), identified by a unique identifier (field
    <code>ID</code>). We consider as an event when one single case or
    several epidemiologically related cases were identified by the
    presence of viral RNA (proof of infection) and/or antibodies (proof
    of exposure) in an animal. Epidemiologically related cases include
    e.g. animals belonging to the same farm, captive animals housed
    together, pets belonging to the same household, or animals sampled
    within the same (generally transversal) study, featuring similar
    event and patient attributes, i.e. they underwent the same
    laboratory test(s) and showed the same results (including variant),
    exhibited the same symptoms and disease outcome, and were confirmed,
    reported (when applicable), and published on the same date
    (e.g. when pets of the same species sharing the same household
    showed different symptoms, they are reported as two distinct
    events). Events include follow-up history reports of outbreaks
    (e.g. follow-up on the clinical status of the animal, variant
    identification after case confirmation). <br>

-   Each SARS-CoV-2 event is characterized by 50 quantitative and
    qualitative event and patient attributes (**columns**) that
    structure the dataset. <br>

### Field dictionary

<code>ID</code> Unique identifier for each unique event of SARS-CoV-2
infection/exposure in animal(s).<br>

<code>primary_source</code> Primary source of information to document
the event. Possible pre-defined string values are: *ProMED*; *WAHIS*.
<br>

<code>archive_event_number</code> Unique identifier for the report, as
provided by the primary source. Also corresponds to the name of the PDF
file describing the event in the <code>sars_ani_PDF_archives</code>
folder. <br>

<code>link_web</code> Link to the online primary source to document the
event.<br>  
<code>secondary_source</code> Secondary source of information to
document the event. Possible pre-defined string values are: *ProMED*;
*WAHIS*.<br>

<code>secondary_source_ID</code> Unique identifier for the report, as
provided by the secondary source. Also corresponds to the name of the
PDF file describing the event in the <code>sars_ani_PDF_archives</code>
folder.<br>

<code>secondary_source_web</code> Link to the online secondary source
for the event.<br>

<code>host_com_orig</code> Most specific designation of the animal host
provided by the source(s), in English. <br>

<code>host_sci_orig</code> Scientific name of the animal host as
mentioned in the source(s) (scientific names are harmonized so that only
the first letter of the genus is capitalized). <br>

<code>host_com_res</code> Common name of the animal host, harmonized
against the National Center for Biotechnology Information
([NCBI](https://www.ncbi.nlm.nih.gov/)) taxonomic backbone.<br>

<code>host_sci_res</code> Scientific name of the animal host (resolved
to species or subspecies level), harmonized against the National Center
for Biotechnology Information ([NCBI](https://www.ncbi.nlm.nih.gov/))
taxonomic backbone.<br>

<code>host_colloq</code> The colloquial name of the host, i.e. the name
commonly used to identify the animal in non-specialist language
(e.g. “tiger” for “Sumatran tiger”).<br>

<code>host_sci_spec_res</code> The scientific name of the host resolved
to the species level.<br>

<code>family</code> Animal family of the animal host. <br>

<code>epidemiological_unit</code> The epidemiological unit considered to
describe the event. Possible pre-defined string values are: *animal* =
one individual; *group* = a group of animals housed/living together
(excluding farm animals), e.g. zoo animals, pets; *survey group* =
animals that have been sampled in different locations within the same
surveillance programme or survey study; *farm*: a group of animals
belonging to the same species and bred for commercial purposes. <br>  
<code>number_cases</code> Reported number of animal(s) tested positive
for SARS-CoV-2 in the event. <br>

<code>number_susceptible</code> Reported number of susceptible animal(s)
of the same species in the event. <br>

<code>number_tested</code> Reported number of animal(s) of the same
species tested in the event.<br>

<code>number_deaths</code> Reported number of direct and indirect
death(s) related to the event. If death is not related to SARS-CoV-2
(see field <code>outcome</code>), <code>number_deaths</code> = 0.<br>

<code>age</code> Age of the animal(s) when tested, in years. <br>

<code>sex</code> Sex of the animal(s). Possible pre-defined values are:
*f* = female; *m* = male. <br>

<code>country_iso3</code> Three-digit ISO country code for the country
where the SARS-CoV-2 event was reported.<br>

<code>country_name</code> Name of the country where the SARS-CoV-2 event
was reported. <br>

<code>subnational_administration</code> The subnational administrative
region where the SARS-CoV-2 event was reported. <br>

<code>city</code> The city where the SARS-CoV-2 event was reported. <br>

<code>location_detail</code> Specification of the geographic location
enabling to discriminate SARS-CoV-2 events occurring in the same
species, at the same date and geolocation
(<code>subnational_administration</code>, <code>city</code>), when the
report(s) clearly stipulates that animal(s) were not geolocated at the
same place (e.g. different farms or households). <br>

<code>date_confirmed</code> When the SARS-CoV-2 infection or exposure
was laboratory confirmed. <br>

<code>date_reported</code> When the SARS-CoV-2 event was reported by the
WAHIS. <br>

<code>date_published</code> When the primary source published the
SARS-CoV-2 event (<code>date_published</code> =
<code>date_reported</code> when WAHIS is the primary source). <br>

<code>related_to_other_entries</code> Relationship with another record
(see field <code>related_ID</code>) in the dataset. Possible pre-defined
string values are: *new* = the event is not related to any event
previously entered in the dataset and no follow-up event exists but it
can be related to an event that was reported on the same day or later in
time with one of the following values:
<code>related_to_other_entries</code> = *living together* or
<code>related_to_other_entries</code> = *connected* or
<code>related_to_other_entries</code> = *same study*; *updated by* = the
event has a follow-up event in the dataset, which itself presents the
value *update of*. Therefore, a *new* event gets the value *updated by*
when a follow-up related event is entered; *update of* = the event is a
follow-up of an event previously entered in the dataset; *living
together* = the animal(s) described in the event share(s) the same
geolocation (e.g. farm, household, pet store) as another (other)
animal(s) that has/have been previously entered in the dataset; *same
study* = the event reports infection in animal(s) belonging to a study
that was previously entered in the dataset; *connected* = the event is
epidemiologically related to a previously reported event in the dataset
(e.g. SARS-CoV-2 events in pet hamsters in pet shops in Hong Kong,
following a single importation of infected individuals from the
Netherlands). <br>

<code>related_ID</code> Unique identifier of the related entry in the
dataset. <br>

<code>test</code> First type of laboratory test performed to detect
infection with (presence of the virus is evidenced) or exposure to
(presence of antibodies is evidenced) SARS-CoV-2. <br>

<code>sampling_type</code> Type of sample collected to perform the test
(<code>test</code>). <br>

<code>test_2</code> Second type of laboratory test performed to detect
infection with (presence of the virus is evidenced) or exposure to
(presence of antibodies is evidenced) SARS-CoV-2. <br>

<code>sampling_type_2</code> Type of sample collected to perform the
second test (<code>test_2</code>). <br>

<code>test_3</code> Third type of laboratory test performed to detect
infection with (presence of the virus is evidenced) or exposure to
(presence of antibodies is evidenced) SARS-CoV-2. <br>  
<code>sampling_type_3</code> Type of sample collected to perform the
third test (<code>test_3</code>). <br>

<code>negative_test</code> First type of laboratory test mentioned in
the report, which outcome was negative. <br>

<code>negative_sampling_type</code> Type of sample collected to perform
the first test (<code>negative_test</code>) that led to negative result.
<br>

<code>negative_test_2</code> Second type of laboratory test mentioned in
the report, which outcome was negative. <br>

<code>negative_sampling_type_2</code> Type of sample collected to
perform the second test (<code>negative_test_2</code>) that led to
negative result. <br>

<code>reason_for_testing</code> Rationale for testing the animal(s).
<br>

<code>symptoms</code> Reported clinical signs allegedly associated to
SARS-CoV-2. <br>

<code>outcome</code> Issue of the SARS-CoV-2 infection (or exposure).
<br>

<code>living_conditions</code> How/where the animal(s) live(s). <br>

<code>source_of_infection</code> Most probable source of SARS-CoV-2
infection. <br>

<code>variant</code> SARS-CoV-2 genetic variant. <br>

<code>control_measures</code> Main intervention(s) implemented to
mitigate further spread of the virus. <br>

<code>original_source</code> Information source cited by the primary
source. <br>

<code>link_original_source</code> Link to the online source cited by the
primary source (when applicable). <br>

#### Note

We have considered the two following values throughout the dataset: <br>

-   <code>NS</code> Not specified: the information would be relevant for
    the event but the information was not mentioned in the primary or
    secondary source. <br>  
-   <code>NA</code> Not applicable: the field is not applicable in this
    case. <br>

## Contributors <a name="Contributors"></a>

-   Afra Nerpel, [University of Veterinary Medicine Vienna,
    Austria](https://www.vetmeduni.ac.at/) <br>  
-   Liuhuaying Yang, [Complexity Science Hub Vienna,
    Austria](https://www.csh.ac.at)<br>  
-   Johannes Sorger, [Complexity Science Hub Vienna,
    Austria](https://www.csh.ac.at)<br>  
-   Annemarie Käsbohrer, [University of Veterinary Medicine Vienna,
    Austria](https://www.vetmeduni.ac.at/)<br>
-   Chris Walzer, [Wildlife Conservation Society, New York, United
    States](https://www.wcs.org/) / [University of Veterinary Medicine
    Vienna, Austria](https://www.vetmeduni.ac.at/)<br>  
-   Amélie Desvars-Larrive, [University of Veterinary Medicine Vienna,
    Austria](https://www.vetmeduni.ac.at/) / [Complexity Science Hub
    Vienna, Austria](https://www.csh.ac.at)<br>

## License <a name="License"></a>

This project is licensed under the CC BY-SA 4.0 License - see the [CC
BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/deed.en) file
for details.

## Contact <a name="Contact"></a>

[Amélie Desvars-Larrive](https://github.com/amel-github) <br> Email:
[amelie.desvars@vetmeduni.ac.at](amelie.desvars@vetmeduni.ac.at)

## Disclaimer <a name="Disclaimer"></a>

*The World Organisation for Animal Health (WOAH) bears no responsibility
for the integrity or accuracy of the data contained herein, in
particular due, but not limited to, any deletion, manipulation, or
reformatting of data that may have occurred beyond its control.*
