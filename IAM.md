## IAM Permission

The Policy required to deploy this module:

```hcl
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole",
                "iam:DeleteServiceLinkedRole",
                "iam:GetRole",
                "iam:GetServiceLinkedRoleDeletionStatus",
                "iam:UpdateRoleDescription"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "kms:DescribeKey"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:DeleteLogGroup",
                "logs:DeleteResourcePolicy",
                "logs:DeleteRetentionPolicy",
                "logs:DescribeLogGroups",
                "logs:DescribeResourcePolicies",
                "logs:ListTagsLogGroup",
                "logs:PutResourcePolicy",
                "logs:PutRetentionPolicy",
                "logs:TagLogGroup",
                "logs:UntagLogGroup"
            ],
            "Resource": [
                "*"
            ]
        }
    ]

```