Read me:
This is the day 3 task of infrastructure as code with aws as cloud provider using terraform.
this task is to provision an s3 bucket in the account of the user to store files such as *.tf.state files, *.terraform.lock fiels which are heavy to store in git and need to be secure for the infrastuctre code resuability.

Task:
The task is to provision the bucket with unique name as global bucket for account as s3 is a global aws service.
and upload objects to s3 account and keep track of the bucket state and object uploaded,  with proper iam permisisions configured and bucket policies.