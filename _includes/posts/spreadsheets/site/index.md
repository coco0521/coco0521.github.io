# Get Started

### Download

<a href="http://activespaces.tibco.com/nexus/service/local/artifact/maven/redirect?r=releases&amp;g=com.tibco.as&amp;a=as-spreadsheets&amp;v=2.0.4&amp;e=zip&amp;c=distribution" target="_blank" class="btn btn-primary">as-spreadsheets-2.0.4</a>

<a href="https://github.com/TIBCOSoftware/as-spreadsheets" target="_blank">Source</a>

<a href="https://raw.githubusercontent.com/TIBCOSoftware/as-spreadsheets/master/LICENSE" target="_blank">License</a>

### Installation

Unzip the distribution and make sure the executable, located under the bin folder, has the proper execution permissions.

### Get help

	as-spreadsheets -help

### Import a file

	as-spreadsheets import ../examples/jazzfunk.xlsx -header -distribution_role seeder

### Import a spreadsheet

	as-spreadsheets import ../examples/jazzfunk.xlsx -sheet album -header -distribution_role seeder

### Import a headerless spreadsheet

	as-spreadsheets import ../examples/jazzfunk-noheader.xls -sheet artist -distribution_role seeder -fields "id[LONG key]" "name[STRING]" "birthdate[DATETIME nullable]"

### Export a metaspace

	as-spreadsheets export

### Export spaces

	as-spreadsheets export artist album
