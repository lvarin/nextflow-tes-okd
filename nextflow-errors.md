# List of Nextflow errors

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
