resource "aws_security_group" "sg-ec2-public" {
  name   = "${var.init.env}-sg-public"
  vpc_id =  aws_vpc.main.id

  ingress {
    description = "sg-ingress-tcp"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "sg-ingress-ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_ec2-public"
  }
}

resource "aws_security_group" "sg-ec2-private" {
  name   = "${var.init.env}-sg-private"
  vpc_id =  aws_vpc.main.id

  ingress {
    description = "sg-ingress-tcp"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "sg-ingress-ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_ec2-private"
  }
}

resource "aws_key_pair" "key1" {
  key_name   = "key1"
  public_key = "ssh-rsa 9d6UsQy1Z5GXZsWJhiK+vgDgxOzusA2Y//2IcAVs0jLxyqgYMKOgq5VhZr4B+9w89JD7CqDwpAcRRZvCpy5LIrvPpGral9NpAEqOyOVzc5GO0v+iOMFQsHfOOrBc6XC3mhXJW+x/qR4S40t+8cCfGAZPlSVIH/avgtr+ZR+MIRnVfDIVn0EpLKIoMUpq951SQjD5EIKbUxrceLUU8p1ekXhh+l3UFYD5vOC2naMomgIz8uwb/DlwNZ0L5g5Sz/r3lM53Rz5a1naA2qfl3pbuNckCJx/Ncy/g8aehPAlEHWMqlii078NWiiZLRyjK0kOXPrRE781Fn6+0fyNnkKMC15z4hF3nK2eUwrN8w60Yujuq545C6QTlM4UBSTcF5m6a7WMUOIJs47b94vJjyju6ChRSTe9lv0kBG4WBrDQWvlW4D4GILyo3X9JKMrNl3OrgaCVldijKV3S7RBiD03uDJJJWNeuZiV7q44ZYfEZr6zksAFXsNlQ1rfOtfaJhCrH1fotrSvwXt4os/Y8Yhsq9EoGeKzLnKjtnZsvQCCFUAfcvcmYGrme1GzCm0yglbahVU2BT6NRMQ== gpb@p1gen5"
}

resource "aws_instance" "ec2_public1" {
  ami                    = "ami-0e04bcbe83a83792e"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg-ec2-public.id]
  subnet_id              = aws_subnet.public_zone1.id
  key_name               = aws_key_pair.key1.key_name

tags = {
    Name = "${var.init.env}-ec2_public1"
  }
}

resource "aws_instance" "ec2_private1" {
  ami                    = "ami-0e04bcbe83a83792e"
  instance_type          = "c7g.4xlarge"
  vpc_security_group_ids = [aws_security_group.sg-ec2-private.id]
  subnet_id              = aws_subnet.private_zone1.id
  key_name               = aws_key_pair.key1.key_name
  user_data              = base64encode(file("userdata_qs_sim.sh"))

tags = {
    Name = "${var.init.env}-ec2_private1"
  }
}


resource "aws_instance" "ec2_public2" {
  ami                    = "ami-0e04bcbe83a83792e"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg-ec2-public.id]
  subnet_id              = aws_subnet.public_zone2.id
  key_name               = aws_key_pair.key1.key_name

tags = {
    Name = "${var.init.env}-ec2_public2"
  }
}

resource "aws_instance" "ec2_private2" {
  ami                    = "ami-0e04bcbe83a83792e"
  instance_type          = "c7g.4xlarge"
  vpc_security_group_ids = [aws_security_group.sg-ec2-private.id]
  subnet_id              = aws_subnet.private_zone2.id
  key_name               = aws_key_pair.key1.key_name
  user_data              = base64encode(file("userdata_qs_sim.sh"))

tags = {
    Name = "${var.init.env}-ec2_private2"
  }
}
