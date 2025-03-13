resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t2.micro"
  db_name             = "mydatabase"
  username           = "tejaswi"
  password           = "tejaswidb"
  skip_final_snapshot = true
  publicly_accessible = false
}
