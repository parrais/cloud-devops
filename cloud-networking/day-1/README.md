# Cloud Networking Basic Overview

## VPCs

[AWS Docs](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)

- **What are VPCs?**
  - A **Virtual Private Cloud** is a secure, isolated private cloud hosted within a public cloud.
- **Why use/create/customise them?**
  - VPCs combine the scalability and convenience of public cloud computing with the data isolation of private cloud computing.
- **What would a default VPC looklike?**
  - A VPC will have a dedicated subnet and VLAN that are only accessible by the VPC customer. This prevents anyone else within the public cloud from accessing computing resources within the VPC. The VPC customer connects via VPN to their VPC, so that data passing into and out of the VPC is not visible to other public cloud users.
- **What are the core components?**
  - Subnets, VLAN, VPN.

## IP addresses

[AWS Docs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-ip-addressing.html)

- **Public vs Private IP addresses**
  - A Private IP Address is used for communication within a local network (LAN). It allows devices to send and receive data internally. Private IPs are not visible on the internet, making them more secure than public IPs.
  - A Public IP Address of a system is the IP address that is used to communicate outside the network.
- **IPv4 vs IPv6**
  - IPv4 has a 32-bit address space from 0.0.0.0 to 255.255.255.255.
  - IPv6 has a 128-bit address space.
- **CIDR blocks**
  - **[Classless Inter-Domain Routing](https://aws.amazon.com/what-is/cidr/)** is an IP address allocation method. 'Slash notation' includes an address in the network, followed by a slash, then the 'network prefix' which is the number of bits (out of 32 total available) outside the network.
- **Subnet masks**

  - 1 for each bit of network prefix, 0 for each bit in scope of network, rendered as a decimal IPv4 address.

    ![IPv4 CIDR Chart](https://www.ripe.net/media/images/IPv4CIDRChart_2015.width-800.jpg)

- **Reserved IP ranges**
  - Some IP address ranges are reserved for specific purposes, e.g.
    - Private networks (10.0.0.0–10.255.255.255, 172.16.0.0–172.31.255.255, 192.168.0.0–192.168.255.255)
    - Localhost (127.0.0.1)
- **What is NAT?**
  - **Network Address Translation** matches private IP addresses to a public IP address for connections with the public Internet. With NAT, a public-facing website or application could run in a VPC.

## Subnets

[AWS Docs](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html)

- **Public and Private subnets**
  - Public subnet – The subnet has a direct route to an internet gateway. Resources in a public subnet can access the public internet.
  - Private subnet – The subnet does not have a direct route to an internet gateway. Resources in a private subnet require a NAT device to access the public internet.
- **How do AZs relate to subnets?**
  - Each subnet must reside entirely within one Availability Zone and cannot span zones.

## Gateways

[Article](https://medium.com/awesome-cloud/aws-vpc-difference-between-internet-gateway-and-nat-gateway-c9177e710af6)
![IGW vs NGW](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*gftv4LSqU_12kRqNwYISJw.png)

- **NAT Gateways vs Internet Gateways**
  - Internet Gateway (IGW) allows instances with public IPs to access the internet.
  - NAT Gateway (NGW) allows instances with no public IPs to access the internet.
- **How do public subnets access the internet?**
  - Internet Gateway enables resources (like EC2 instances) in public subnets to connect to the internet. Similarly, resources on the internet can initiate a connection to resources in your subnet using the public.
- **Why do private subnets need NAT?**
  - NAT Gateway does something similar to Internet Gateway (IGW), but it only works one way: Instances in a private subnet can connect to services outside your VPC but external services cannot initiate a connection with those instances.
- **Are there cost differences?**
  - There’s no additional charge for having an internet gateway in your account.
  - You are charged for each hour that your NAT gateway is available and each Gigabyte of data that it processes.
- **Different architectures?**
  - Internet Gateway is not Availability Zone specific.
  - Each NAT gateway is created in a specific Availability Zone and implemented with redundancy in that zone.

## Route Tables

[AWS Docs](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html)

A route table serves as the traffic controller for your virtual private cloud (VPC). Each route table contains a set of rules, called routes, that determine where network traffic from your subnet or gateway is directed.

- **What does a "default" route table look like?**
  - When you create a VPC, it automatically has a main route table. When a subnet does not have an explicit routing table associated with it, the main routing table is used by default. By default, when you create a nondefault VPC, the main route table contains only a local route.
- **Local routing**
  - Corresponds to only the instance itself.
- **0.0.0.0/0 routing**
  - Corresponds to the whole public internet.
- **Routes to NAT gateway vs internet gateway**
  - TBC
- **How do RT association work?**
  - [AWS Docs](https://docs.aws.amazon.com/vpc/latest/userguide/associate-route-table-gateway.html)

## SGs and NACLs

[AWS Docs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html)

- **What are ports?**
  - Ports are communication endpoints on a computer, range is from 0 to 65535.
- **Inbound vs Outbound rules**
  - When you create a VPC, it comes with a default security group. You can create additional security groups for a VPC, each with their own inbound and outbound rules. You can specify the source, port range, and protocol for each inbound rule. You can specify the destination, port range, and protocol for each outbound rule.
- **Stateful vs stateless**
  - Security groups are stateful. For example, if you send a request from an instance, the response traffic for that request is allowed to reach the instance regardless of the inbound security group rules. Responses to allowed inbound traffic are allowed to leave the instance, regardless of the outbound rules.
- **SG referencing**
  - [AWS Docs](https://docs.aws.amazon.com/vpc/latest/userguide/security-group-rules.html#security-group-referencing)
- **Common SG architectures**
  - TBC
