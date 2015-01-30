require "refile/backend/s3"

secrets = Rails.application.secrets
aws = {
  access_key_id: secrets.aws_access_key_id,
  secret_access_key: secrets.aws_secret_access_key,
  bucket: secrets.aws_bucket
}
Refile.cache = Refile::Backend::S3.new(prefix: "cache", **aws)
Refile.store = Refile::Backend::S3.new(prefix: "store", **aws)
