# Configuration

Spreadsheets is a command line tool to import/export Excel spreadsheets.

It supports the following file formats:

* Microsoft Excel 97-2003 worksheets (xls)
* Microsoft Excel 2007 workbook (xlsx)

## Import

If not specified Spreadsheets uses the sheet name as the space name.

If the space does not exist and the `-header` option is set, a space def is created from the [field defs on the first row](#header). 

Each row in the spreadsheet is then converted into a tuple which is put into the space.


## Export

If not specified Spreadsheets uses the metaspace name as the output filename, and each space is exported to a separate spreadsheet with the same name.

If the `-header` option is set, [field defs are written to the first row](#header).

A browse is then performed on the space and each returned tuple is converted to a row which is written to the spreadsheet.


## <a name="header"></a>Header

The first row in the spreadsheet describes the space fields and keys.

Each field definition (including key) is encoded to a cell in the form:

	name[type encrypted nullable key]

Key fields can also be indicated in bold, e.g.

<table>
    <tr>
        <td><code><strong>id[LONG]</strong></code></td>
        <td><code>name[STRING nullable]</code></td>
        <td><code>account[LONG encrypted]</code></td>
    </tr>
</table>

is equivalent to

<table>
    <tr>
        <td><code>id[LONG key]</code></td>
        <td><code>name[STRING nullable]</code></td>
        <td><code>account[LONG encrypted]</code></td>
    </tr>
</table>
