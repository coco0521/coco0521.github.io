# Introduction

## Import

If not specified, Files for TIBCO ActiveSpaces uses the base filename as the space name e.g. `space1.csv` -> `space1`.

If the space does not exist and the `header` option is set, a space def is created from the fields defs in the [header](#header). 

Each line in the file is then converted into a tuple which is put into the space.


## Export

Each space is exported to a file named &lt;`space name`&gt;`.csv`.

If the `header` option is set, a [header](#header) is written containing field defs.

A browse is then performed on the space and each returned tuple is converted into a line which is written to the file.


## <a name="header"></a>Header

The first line in the file describes the space fields and keys.

### Header Format

Each field is encoded in the form

	name[type encrypted nullable key]

e.g.

<table>
    <tr>
        <td><code>"id[LONG key]"</code></td>
        <td><code>"name[STRING nullable]"</code></td>
        <td><code>"account[LONG encrypted nullable]"</code></td>
    </tr>
</table>

### Ignoring Fields

If a field descriptor is left empty, it is ignored by the import/export process.

e.g.

<table>
	<tr>
	    <td><code>"id[LONG key]"</code></td>
        <td><code>""</code></td>
        <td><code>"account[LONG encrypted nullable]"</code></td>
    </tr>
</table>
	
	