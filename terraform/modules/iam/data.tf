# This file defines data sources for the IAM module, including the current AWS caller identity and IAM policy documents for ECS instance and Code Build assume roles.


data "aws_caller_identity" "current" {}  #use this to get my AWS account ID for the policy documents


# For ECS instances to be able to assume the role, we need to create an assume role policy document that allows EC2 to assume the role.
data "aws_iam_policy_document" "ecs_instance_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}



# For Code Build to be able to assume the role, we need to create an assume role policy document that allows Code Build to assume the role.
data "aws_iam_policy_document" "codebuild_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "codebuild_policy" {

  #Cloud Watch logs permissions for Code Build to create log groups and log streams, and to put log events.  
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"] # Adjust to specific log group ARNs for better security
  }


    # S# permissions for pipeline artifacts.
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
    ]
    resources = [
    "arn:aws:s3:::${var.bucket_name}/*", 
    "arn:aws:s3:::${var.bucket_name}"
]
  }

  # ECR permissions for Code Build to pull images from ECR.
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"] # ECR authorization token is a global resource, so we use "*" here.
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
      ]

      resources = ["arn:aws:ecr:${var.region}:${data.aws_caller_identity.current.account_id}:repository/${var.ecr_repository_name}"
]
  }



# ECS permissions for Code Build to update the ECS service after a successful build.
statement {
  effect = "Allow"
  actions = [
    "ecs:UpdateService",
    "ecs:DescribeServices"
  ]

  resources = [
    "arn:aws:ecs:${var.region}:${data.aws_caller_identity.current.account_id}:service/${var.cluster_name}/${var.service_name}"
  ]
}

# ECSTask Definition Permissions
statement {
  effect = "Allow"
  actions = [
    "ecs:RegisterTaskDefinition",
    "ecs:DescribeTaskDefinition"
  ]

  resources = [
    "arn:aws:ecs:${var.region}:${data.aws_caller_identity.current.account_id}:task-definition/${var.service_name}*"
  ]
}

}

