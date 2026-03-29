resource "aws_iam_role" "docker_server_role" {
  name = "docker-server-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "docker-server-role"
  }
}


resource "aws_iam_role_policy" "docker_server_ecr_policy" {
  name = "docker-server-ecr-policy"
  role = aws_iam_role.docker_server_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy" "docker_server_ecs_policy" {
  name = "docker-server-ecs-policy"
  role = aws_iam_role.docker_server_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecs:DescribeServices",
          "ecs:UpdateService",
          "ecs:ListTasks",
          "ecs:DescribeTasks"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "docker_server_profile" {
  name = "docker-server-instance-profile"
  role = aws_iam_role.docker_server_role.name
}