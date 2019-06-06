#
# RDS resources
#

resource "aws_db_instance" "postgresql" {
  count                      = "${var.db_count}"
  allocated_storage          = "${var.allocated_storage}"
  engine                     = "postgres"
  engine_version             = "${var.engine_version}"
  identifier                 = "${lookup(var.identifiers, count.index)}"
  instance_class             = "${lookup(var.instance_types, "size_${count.index}_${terraform.env}.db_instance_type")}"
  storage_type               = "${var.storage_type}"
  name                       = "${var.database_name}"
  password                   = "${lookup(var.passwords, count.index)}"
  username                   = "${var.database_username}"
  backup_retention_period    = "${var.backup_retention_period}"
  backup_window              = "${var.backup_window}"
  maintenance_window         = "${var.maintenance_window}"
  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"
  final_snapshot_identifier  = "${var.final_snapshot_identifier}"
  skip_final_snapshot        = "${var.skip_final_snapshot}"
  copy_tags_to_snapshot      = "${var.copy_tags_to_snapshot}"
  multi_az                   = "${var.multi_availability_zone}"
  port                       = "${var.database_port}"
  vpc_security_group_ids     = ["${var.vpc_security_group_ids}"]
  db_subnet_group_name       = "${var.subnet_group}"
  parameter_group_name       = "${var.parameter_group}"
  storage_encrypted          = "${lookup(var.storage_encrypted_map, "encrypted_${count.index}")}"

  tags {
    Name        = "DatabaseServer"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

#
# CloudWatch resources
#

resource "aws_cloudwatch_metric_alarm" "database_cpu" {
  count               = "${var.db_count}"
  alarm_name          = "${lookup(var.identifiers, count.index)}${var.environment}DatabaseServerCPUUtilization"
  alarm_description   = "Database server CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.alarm_cpu_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.postgresql.*.id[count.index]}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}

resource "aws_cloudwatch_metric_alarm" "database_disk_queue" {
  count               = "${var.db_count}"
  alarm_name          = "${lookup(var.identifiers, count.index)}${var.environment}DatabaseServerDiskQueueDepth"
  alarm_description   = "Database server disk queue depth"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "DiskQueueDepth"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.alarm_disk_queue_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.postgresql.*.id[count.index]}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}

resource "aws_cloudwatch_metric_alarm" "database_disk_free" {
  count               = "${var.db_count}"
  alarm_name          = "${lookup(var.identifiers, count.index)}${var.environment}DatabaseServerFreeStorageSpace"
  alarm_description   = "Database server free storage space"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.alarm_free_disk_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.postgresql.*.id[count.index]}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}

resource "aws_cloudwatch_metric_alarm" "database_memory_free" {
  count               = "${var.db_count}"
  alarm_name          = "${lookup(var.identifiers, count.index)}${var.environment}DatabaseServerFreeableMemory"
  alarm_description   = "Database server freeable memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.alarm_free_memory_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.postgresql.*.id[count.index]}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}
