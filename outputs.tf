output "bucket_name" {
  description = "Nome do bucket criado"
  value       = mgc_object_storage_buckets.this.bucket
}

output "bucket_final_name" {
  description = "Nome final do bucket, incluindo prefixo e sufixo auto-gerado"
  value       = mgc_object_storage_buckets.this.final_name
}

output "bucket_versioning_enabled" {
  description = "Status do versionamento do bucket"
  value       = mgc_object_storage_buckets.this.enable_versioning
}

output "bucket_id" {
  description = "ID/Nome final do bucket (identificador único)"
  value       = mgc_object_storage_buckets.this.final_name
}

# Outputs do data source
output "bucket_details" {
  description = "Detalhes completos do bucket"
  value = {
    name       = data.mgc_object_storage_bucket.this.name
    versioning = data.mgc_object_storage_bucket.this.versioning
    policy     = data.mgc_object_storage_bucket.this.policy
    mfadelete  = data.mgc_object_storage_bucket.this.mfadelete
  }
}

output "bucket_versioning_status" {
  description = "Status detalhado do versionamento do bucket"
  value       = data.mgc_object_storage_bucket.this.versioning
}

output "bucket_access_policy" {
  description = "Política de acesso do bucket"
  value       = data.mgc_object_storage_bucket.this.policy
}
