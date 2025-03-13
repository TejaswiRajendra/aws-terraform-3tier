resource "aws_db_instance" "my_rds" {
  identifier             = "terraform-rds-instance"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.35"  # Use a supported version
  instance_class         = "db.t3.micro"  # Use t3.micro instead of t2.micro
  username              = "tejaswi"
  password              = "tejaswidb"
  publicly_accessible   = false
  skip_final_snapshot   = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name  = aws_db_subnet_group.my_subnet_group.name
}

resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

