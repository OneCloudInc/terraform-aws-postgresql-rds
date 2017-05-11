output "id" {
  value = "${aws_db_instance.postgresql.id}"
}

output "database_security_group_ids" {
  value = "${aws_db_instance.postgresql.vpc_security_group_ids}"
}

output "hostname" {
  value = "${aws_db_instance.postgresql.address}"
}

output "port" {
  value = "${aws_db_instance.postgresql.port}"
}

output "endpoint" {
  value = "${aws_db_instance.postgresql.endpoint}"
}
