variable "project" {
  default = "Unknown"
}

variable "environment" {
  default = "Unknown"
}

variable "allocated_storage" {
  default = "32"
}

variable "engine_version" {
  default = "9.5.2"
}

variable "instance_type" {
  default = "db.t2.micro"
}

variable "storage_type" {
  default = "gp2"
}

variable "vpc_id" {}

variable "database_name" {}

variable "passwords" {
  type = "map"
}

variable "allocated_storages" {
  type = "map"
}

variable "database_username" {}

variable "database_port" {
  default = "5432"
}

variable "backup_retention_period" {
  default = "30"
}

variable "backup_window" {
  # 12:00AM-12:30AM ET
  default = "04:00-04:30"
}

variable "maintenance_window" {
  # SUN 12:30AM-01:30AM ET
  default = "sun:04:30-sun:05:30"
}

variable "auto_minor_version_upgrade" {
  default = true
}

variable "final_snapshot_identifier" {
  default = "terraform-aws-postgresql-rds-snapshot"
}

variable "skip_final_snapshot" {
  default = true
}

variable "copy_tags_to_snapshot" {
  default = false
}

variable "multi_availability_zone" {
  default = false
}

variable "storage_encrypted" {
  default = false
}

variable "subnet_group" {}

variable "parameter_group" {
  default = "default.postgres9.4"
}

variable "alarm_cpu_threshold" {
  default = "75"
}

variable "alarm_disk_queue_threshold" {
  default = "10"
}

variable "alarm_free_disk_threshold" {
  # 5GB
  default = "5000000000"
}

variable "alarm_free_memory_threshold" {
  # 128MB
  default = "128000000"
}

variable "alarm_actions" {
  type = "list"
}

variable "vpc_security_group_ids" {
  type = "list"
}

variable "identifiers" {
  type = "map"
}

variable "db_count" {
  default = "1"
}

variable "instance_types" {
  type = "map"
}

variable "storage_encrypted_map" {
  type = "map"
}
