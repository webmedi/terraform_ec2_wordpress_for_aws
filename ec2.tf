####################
# AMI
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
####################
data "aws_ami" "myAmi" {
    most_recent = "true" # 最新のAMIを常に使用する。
    owners = [
        "amazon"
    ]
    filter {
        name = "name" # The name of the AMI that was provided during image creation
        values = [
            # aws ec2 describe-images --owners amazon | grep -C 20 ami-01748a72bed07727c
            "amzn2-ami-hvm-*-x86_64-gp2"
        ]
    }
}

####################
# EC2 Instance
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
####################
resource "aws_instance" "myAmazonLinux2" {
    ami = data.aws_ami.myAmi.id
    instance_type = "t2.nano"
    subnet_id = aws_subnet.mySubnetPub1a.id
    vpc_security_group_ids = [
        aws_security_group.sgEc2.id
    ]
    user_data = file("userdata.sh")

    tags = {
      "Name" = "Amazon Linux2 インスタンス"
    }
}
