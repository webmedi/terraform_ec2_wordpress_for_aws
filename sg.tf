####################
# Security Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
####################
resource "aws_security_group" "sgEc2" {
    name = "fw-ec2"
    description = "SG_EC2"
    vpc_id = aws_vpc.myVpc.id
}

####################
# Security Group Rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
####################
resource "aws_security_group_rule" "sgEc2Accept80" {
    security_group_id = aws_security_group.sgEc2.id
    type = "ingress"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "SG_EC2_ACCEPT_80"
}

resource "aws_security_group_rule" "sgEc2Accept0" {
    security_group_id = aws_security_group.sgEc2.id
    type = "egress"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "SG_EC2_ACCEPT_ANY_OUTBOUND"
}
