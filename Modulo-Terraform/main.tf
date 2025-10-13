module "s3"{
  source      = "./modules/s3"
  org_name    = "ifba"
  bucket_name = "bucket-terraform"
}