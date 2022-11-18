module "container" {
    source = "../../module/ec2"
    component = "api"
    name_prefix = "aws"
    vpc_id = "abcdef"
    subnet_id = "12345678"
}