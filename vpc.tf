####################
# VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
####################
resource "aws_vpc" "myVpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"

    tags = {
        "Name" = "vpc_ec2_wordpress"
    }
}

####################
# Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
####################
resource "aws_subnet" "mySubnetPub1a" {
  vpc_id = aws_vpc.myVpc.id
  availability_zone = "${var.region}a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = "true"

  tags = {
      Name = "パブリックサブネット-1a"
  }
}

####################
# Route Table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
####################
resource "aws_route_table" "myPubRoute1a" {
    vpc_id = aws_vpc.myVpc.id

    tags = {
      Name = "パブリックルートテーブル"
    }
}

####################
# IGW
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/internet_gateway
####################
resource "aws_internet_gateway" "myIgw" {
  vpc_id = aws_vpc.myVpc.id

  tags = {
    Name = "インターネットゲートウェイ"
  }
}

####################
# Route Rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
####################
resource "aws_route" "myPubRouteRule1a" {
  route_table_id = aws_route_table.myPubRoute1a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.myIgw.id
  depends_on = [aws_route_table.myPubRoute1a]
}

####################
# Route Rule Associcate Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
####################
resource "aws_route_table_association" "myPubRouteRuleAssociatSubnet1a" {
    subnet_id = aws_subnet.mySubnetPub1a.id
    route_table_id = aws_route_table.myPubRoute1a.id
}
