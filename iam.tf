# Document that allows ECS to assume role
data "aws_iam_policy_document" "iam_role_for_ztm_doc" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type        = "Service"
            identifiers = ["ecs-tasks.amazonaws.com"]
        }
    }
}

# Task execution role
resource "aws_iam_role" "iam_role_for_ztm" {
    name               = "ecsTaskExectionRole-ZTM-${var.env}"
    assume_role_policy = data.aws_iam_policy_document.iam_role_for_ztm_doc.json
}

# Execution policy
resource "aws_iam_role_policy_attachment" "task_execution_policy_attachment" {
    role       = aws_iam_role.iam_role_for_ztm.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Document that allows read only access to ZTM secrets in Parameter Store
data "aws_iam_policy_document" "read_only_to_ztm_params_doc" {
    statement {
        actions = ["ssm:DescribeParameters"]
        resources = ["*"]
    }
        statement {
        actions = ["ssm:GetParameters"]
        resources = ["arn:aws:ssm:${var.region}:${var.acc_number}:parameter/${var.env}-ztm/*"]
    }
}

# Read only access to ZTM secrets in Parameter Store Policy
resource "aws_iam_policy" "read_only_to_ztm_params" {
    name   = "AWSSystemsManagerParamaterStoreReadOnly-${var.env}-ztm"
    policy = data.aws_iam_policy_document.read_only_to_ztm_params_doc.json
}

# Attachment read only access to ZTM secrets in Parameter Store document to policy
resource "aws_iam_role_policy_attachment" "read_only_to_ztm_params_attachment" {
    role       = aws_iam_role.iam_role_for_ztm.name
    policy_arn = aws_iam_policy.read_only_to_ztm_params.arn
}
