# wbf-infrastructure

terraform code for the Wissenschaftsbefreiungsfront

## Bootstrapping

1. create a terraform cloud workspace
2. permit terraform cloud to modify GCP project
   - create GCP service account for terraform
   - add its credentials to tf-cloud as `GOOGLE_CREDENTIALS` envvar
3. set up terraform to modify Github repos
  - create a token for a user that can add secrets to the repo
  - add token and username to tf cloud as `GITHUB_TOKEN` and `GITHUB_OWNER`
4. manually enable the `Cloud Resource Manager` API so that tf can enable the other ones

Once tf has run successfully the pipeline in the repo should be able to push images to the registry.

## Managing domains for Cloud Run for externally managed domains

- the service account doing the apply needs to be an owner of the domain
  - verify ownership by adding txt record (get code from search console or webmaster tool)
  - use google.com/webmaster to add them
