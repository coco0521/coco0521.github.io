# Get Started

### Download

<a href="http://activespaces.tibco.com/nexus/service/local/artifact/maven/redirect?r=releases&amp;g=com.tibco.as&amp;a=as-files&amp;v=2.0.7&amp;e=zip&amp;c=distribution" target="_blank" class="btn btn-primary">as-files-2.0.7</a>

<a href="https://github.com/TIBCOSoftware/as-files" target="_blank">Source</a>

<a href="https://raw.githubusercontent.com/TIBCOSoftware/as-files/master/LICENSE" target="_blank">License</a>

### Installation

Unzip the distribution and make sure the executable, located under the bin folder, has the proper execution permissions.

### Get help

	as-files -help

### Import a directory

	as-files import ../examples/jazzfunk -header -distribution_role seeder

### Import a headerless file 

	as-files import ../examples/artist.csv -distribution_role seeder -fields "id[LONG key]" "name[STRING]" "birthDate[DATETIME nullable]"

### Export a metaspace

	as-files export

### Export spaces

	as-files export artist album
