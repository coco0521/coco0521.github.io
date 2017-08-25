# Usage

~~~
Usage: as-spreadsheets [options] [command] [command options]
  Options:
    -data_store
       Directory path for data store
    -discovery
       Discovery URL
    -?, -help
       Print this help message
    -listen
       Listen URL
    -member_name
       Member name
    -metaspace
       Metaspace name
    -no_exit
       Do not shut down after the Eclipse application has ended
    -rx_buffer_size
       Receive buffer size
    -worker_thread_count
       Worker thread count
  Commands:
    import      Import Excel file(s)
      Usage: import [options] The list of files to import
        Options:
          -batch_size
             Transfer output batch size
          -blob_format
             Blob format (base64, hex)
          -distribution_role
             Distribution role (none, leech, seeder)
          -escape
             Character to use for escaping a separator or quote
          -fields
             Comma separated fields
          -header
             Treat first line as header containing field names
          -ignore_leading_whitespace
             Ignore white space in front of a quote in a field
          -operation
             Space operation (get, load, none, partial, put, take)
          -quote
             Character to use for quoted elements
          -separator
             The delimiter to use for separating entries
          -sheet
             Name of sheet to import
          -strict_quotes
             Ignore characters outside the quotes
          -wait_for_ready_timeout
             Wait for ready timeout
          -writer_thread_count
             Number of writer threads

    export      Export space(s) to Excel
      Usage: export [options] The list of spaces to export
        Options:
          -batch_size
             Transfer output batch size
          -blob_format
             Blob format (base64, hex)
          -datetime_format
             Date/time format
          -distribution_scope
             Browser distribution scope
          -excel_version
             Excel version
             Default: EXCEL97
          -fields
             Comma separated fields
          -file
             File to export to
          -filter
             Browser filter
          -no_header
             Do not write a header
          -prefetch
             Browser prefetch
          -query_limit
             Browser query limit
          -time_scope
             Browser time scope
          -timeout
             Browser timeout
          -writer_thread_count
             Number of writer threads
~~~
