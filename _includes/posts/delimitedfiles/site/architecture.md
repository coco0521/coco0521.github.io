# Architecture


## Import

![Architecture Diagram](images/architecture.svg)


### Reading

The file is read by a single thread that parses each line into a string array and puts it in the work queue.


### Writing

Multiple writer threads read from the work queue. The number of writer threads is specified by the `writer_thread_count` parameter and defaults to `1`. 

Each writer dequeues a string array at a time and converts it into a tuple which it accumulates into a tuple list. Once the batch size is reached the writer stores the list into the space using a `putAll` operation (or `put` if batch size is `1`). The batch size is specified with the `batch_size` parameter and  defaults to `1000`. 
