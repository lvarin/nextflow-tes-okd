# List of Nextflow errors

* [Error-finish](#Error-finish)
* [ampa](#ampa)
* [complex-names](#complex-names)

## Error-finish

The workflow [error-finish.nf](https://github.com/nextflow-io/nextflow/blob/master/tests/error-finish.nf) fails on purpose. But TESK fails in a way that it should not.

The command to run it is:

```
/usr/local/bin/nextflow run /tmp/nf/error-finish.nf -with-docker centos -w /mnt
```

One of the tasks fails like this:

```
$ oc logs task-4ddbf1ab-jbgsd                  
Traceback (most recent call last):
  File "/usr/lib/python3.7/site-packages/tesk_core/job.py", line 39, in get_status
    if job.status.conditions[0].type == 'Complete' and job.status.conditions[0].status:
TypeError: 'NoneType' object is not subscriptable

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/bin/taskmaster", line 10, in <module>
    sys.exit(main())
  File "/usr/lib/python3.7/site-packages/tesk_core/taskmaster.py", line 291, in main
    run_task(data, args.filer_name, args.filer_version)
  File "/usr/lib/python3.7/site-packages/tesk_core/taskmaster.py", line 150, in run_task
    run_executor(executor, args.namespace, pvc)
  File "/usr/lib/python3.7/site-packages/tesk_core/taskmaster.py", line 40, in run_executor
    status = job.run_to_completion(poll_interval, check_cancelled,args.pod_timeout)
  File "/usr/lib/python3.7/site-packages/tesk_core/job.py", line 33, in run_to_completion
    status, is_all_pods_running = self.get_status(is_all_pods_running)
  File "/usr/lib/python3.7/site-packages/tesk_core/job.py", line 59, in get_status
    pod.status.container_statuses[0].state.waiting.reason == "ImagePullBackOff":
AttributeError: 'NoneType' object has no attribute 'reason'

```

## ampa

The workflow [ampa.nf](https://github.com/nextflow-io/nextflow/blob/master/tests/ampa.nf):
```
/usr/local/bin/nextflow run /tmp/nf/ampa.nf -with-docker centos -w /mnt
```

fails with the error:

```
N E X T F L O W  ~  version 20.06.0-edge
Launching `/tmp/nf/ampa.nf` [pensive_golick] - revision: 23c6a3c5b3
ERROR: TES executor does not allow the use of custom scripts in the `bin` folder
```

The error comes from here:

<https://github.com/nextflow-io/nextflow/blob/master/modules/nf-ga4gh/src/main/nextflow/ga4gh/tes/executor/TesExecutor.groovy#L50>

## complex-names

The workflow [complex-names.nf](https://github.com/nextflow-io/nextflow/blob/master/tests/complex-names.nf):
```
/usr/local/bin/nextflow run /tmp/nf/complex-names.nf -with-docker centos -w /mnt
```

Puts out this error:
```
08/06/2020 02:11:57 DEBUG: Processed file: /work/01_A(R{1,2}).fastq
08/06/2020 02:11:57 DEBUG: Processing file: /work/sample_(1 2).vcf
08/06/2020 02:11:57 INFO: Could not determine protocol for url: "/mnt/d6/71a973a049c721dd0edf8230abe24a/sample_(1 2).vcf", assuming "file"
08/06/2020 02:11:57 DEBUG: FileTransput uploading Type.File /mnt/d6/71a973a049c721dd0edf8230abe24a/sample_(1 2).vcf
08/06/2020 02:11:57 DEBUG: Copying /work/sample_(1 2).vcf to /mnt/d6/71a973a049c721dd0edf8230abe24a/sample_(1 2).vcf
08/06/2020 02:11:57 DEBUG: Processed file: /work/sample_(1 2).vcf
08/06/2020 02:11:57 DEBUG: Processing file: /work/.alpha
08/06/2020 02:11:57 INFO: Could not determine protocol for url: "/mnt/d6/71a973a049c721dd0edf8230abe24a/.alpha", assuming "file"
08/06/2020 02:11:57 DEBUG: FileTransput uploading Type.File /mnt/d6/71a973a049c721dd0edf8230abe24a/.alpha
08/06/2020 02:11:57 DEBUG: Copying /work/.alpha to /mnt/d6/71a973a049c721dd0edf8230abe24a/.alpha
Traceback (most recent call last):
  File "/usr/bin/filer.py", line 533, in <module>
    sys.exit(main())
  File "/usr/bin/filer.py", line 526, in main
    process_file(args.transputtype, afile)
  File "/usr/bin/filer.py", line 483, in process_file
    return transfer.upload()
  File "/usr/bin/filer.py", line 44, in upload
    return self.upload_file()
  File "/usr/bin/filer.py", line 192, in upload_file
    def upload_file(self):   self.transfer(copyFile  , self.path             , self.urlContainerPath)
  File "/usr/bin/filer.py", line 188, in transfer
    copyFn(src, dst)
  File "/usr/bin/filer.py", line 175, in copyFile
    shutil.copy(file, dst)
  File "/usr/lib/python2.7/shutil.py", line 133, in copy
    copyfile(src, dst)
  File "/usr/lib/python2.7/shutil.py", line 96, in copyfile
    with open(src, 'rb') as fsrc:
IOError: [Errno 21] Is a directory: u'/work/.alpha'
```
