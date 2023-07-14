# quotes-infra

Infrastructure for the quotes-server project.

## Requirements
- [Terraform](https://www.terraform.io/downloads.html) >= 0.14.7
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) >= 337.0.0
- [Docker](https://docs.docker.com/get-docker/) >= 20.10.6
- [Docker Compose](https://docs.docker.com/compose/install/) >= 1.29.1
- [GNU Make](https://www.gnu.org/software/make/) >= 4.3
- TFCloud account (optional, but recommended)


### NB: The very first run
Due to the fact that the first time you run the terraform commands against a new project,
you will not have some important APIs enabled, you might need to enable them manually through the UI console or CLI.
This is a one-time action, and you will not need to do it again.
Bear in mind that enabling APIs might take some time, so you might need to wait a bit before running the commands again.
```
You will need to enable the following APIs in UI:
- Cloud Resource Manager API
- Compute Engine API
- Cloud DNS API
- Cloud Run API
- IAM API
```
Or through CLI by running the following commands:
```shell
gcloud services enable \
cloudresourcemanager.googleapis.com \
compute.googleapis.com \
dns.googleapis.com \
run.googleapis.com \
iam.googleapis.com
```


## Useful commands

## Set gcloud project
```shell
gcloud config set project quotes-test-assignment
```

### Authentication for docker
```shell
gcloud auth configure-docker \
europe-north1-docker.pkg.dev
```

### Add GOOGLE_CREDENTIALS in TFCloud
To strip from new line -
```shell
cat key.json | tr -s '\n' ' '
```
