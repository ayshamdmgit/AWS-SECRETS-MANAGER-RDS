resource "aws_db_subnet_group" "subnet_group" {
  name       = "main"
  subnet_ids = ["Subnet_id_1", "Subnet_id_2"]
}

resource "aws_db_instance" "test_db" {
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name   
  allocated_storage    = 64
  engine               = "postgres"
  identifier.          = "rds-instance"
  instance_class       = "db.t2.micro"
  name                 = "postgres"
  username             = "admin_user"
  password             = "foobarbaz"
  iam_database_authentication_enabled = true
  vpc_security_group_ids = ["Sgs_1", "Sgs_2", "Sgs_3"]
}
