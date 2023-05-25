resource "aws_rds_cluster" "ztm_db_cluster" {
  cluster_identifier              = "${var.env}-ztm-db"
  engine                          = "aurora-mysql"
  availability_zones              = var.availability_zones
  database_name                   = var.db_database_name
  master_username                 = var.db_username
  master_password                 = random_password.db_password.result
  backup_retention_period         = 0
  apply_immediately               = true
  skip_final_snapshot             = true
  storage_encrypted               = true
  vpc_security_group_ids          = ["sg-0dd5f07af97a68983"]
  db_subnet_group_name            = aws_db_subnet_group.ztm_db_subnet_group.name
}

resource "aws_db_subnet_group" "ztm_db_subnet_group" {
  subnet_ids = var.db_subnets
}

resource "aws_rds_cluster_instance" "ztm_db_instance" {
  count                           = 1
  identifier                      = "${aws_rds_cluster.ztm_db_cluster.cluster_identifier}-instance-${count.index}"
  cluster_identifier              = aws_rds_cluster.ztm_db_cluster.id
  instance_class                  = "db.t3.small"
  engine                          = aws_rds_cluster.ztm_db_cluster.engine
  db_subnet_group_name            = aws_db_subnet_group.ztm_db_subnet_group.name
}
