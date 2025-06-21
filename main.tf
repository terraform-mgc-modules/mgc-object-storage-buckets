resource "mgc_object_storage_buckets" "this" {
  bucket             = var.bucket_name
  bucket_is_prefix   = var.bucket_is_prefix
  enable_versioning  = var.enable_versioning
  authenticated_read = var.authenticated_read
  aws_exec_read      = var.aws_exec_read
  private            = var.private
  public_read        = var.public_read
  public_read_write  = var.public_read_write
  recursive          = var.recursive
}

# Data source para consultar detalhes do bucket criado
data "mgc_object_storage_bucket" "this" {
  name = mgc_object_storage_buckets.this.final_name

  depends_on = [mgc_object_storage_buckets.this]
}
