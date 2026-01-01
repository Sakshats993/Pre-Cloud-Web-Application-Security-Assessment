#############################################
# Pre-Cloud Security Terraform Configuration
# Purpose: Security baseline for AWS deployment
#############################################

provider "aws" {
  region = "us-east-1"
}

#############################################
# AWS WAF v2 – Web ACL
#############################################

resource "aws_wafv2_web_acl" "pre_cloud_waf" {
  name  = "pre-cloud-security-waf"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  # SQL Injection Protection
  rule {
    name     = "SQLiProtectionRule"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "SQLiProtectionRule"
      sampled_requests_enabled   = true
    }
  }

  # Known Bad Inputs / XSS Protection
  rule {
    name     = "BadInputsProtectionRule"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BadInputsProtectionRule"
      sampled_requests_enabled   = true
    }
  }

  # Rate Limiting Rule
  rule {
    name     = "RateLimitRule"
    priority = 3

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 2000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimitRule"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "PreCloudWAF"
    sampled_requests_enabled   = true
  }
}

#############################################
# Security Group – Application Layer
#############################################

resource "aws_security_group" "app_sg" {
  name        = "pre-cloud-app-sg"
  description = "Security group for hardened web application"

  ingress {
    description = "HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access (redirect to HTTPS)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "pre-cloud-app-sg"
    Environment = "production"
    Security    = "hardened"
  }
}

#############################################
# IAM – Least Privilege Role (Example)
#############################################

resource "aws_iam_role" "app_role" {
  name = "pre-cloud-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "app_policy" {
  role = aws_iam_role.app_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

#############################################
# Notes
#############################################
# - Attach WAF to ALB / API Gateway
# - Restrict SSH via separate admin SG
# - Store secrets in AWS Secrets Manager
# - Enable CloudTrail & GuardDuty separately
