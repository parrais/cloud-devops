# Terraform

## Key Concepts

### Infrastructure as Code

Infrastructure as Code (IaC) is the managing and provisioning of infrastructure through code instead of manual processes.

With IaC, configuration files are created that contain your infrastructure specifications, which makes it easier to edit and distribute configurations. It also ensures that you provision the same environment every time.

### Orchestration / Configuration Management

**Configuration management** refers to the process of systematically handling and controlling changes to a system's configuration over its lifecycle. It involves managing various aspects, including hardware, software, documentation, and network configurations. The primary objective of configuration management is to maintain consistency and ensure that systems operate reliably while minimizing errors and inconsistencies that can arise from configuration changes.

**Configuration orchestration** focuses on automating the deployment and management of system configurations at scale. It involves coordinating and synchronizing configurations across multiple devices and environments, ensuring consistent and reliable deployment of configurations.

[**Further reading**](https://tasrieit.com/configuration-management-vs-configuration-orchestration-simplifying-system-administration)

### Terraform's Role

Terraform is an Orchestrator.

(Configuration management tools include Ansible, Puppet, and Chef.)

### Terraform's Popularity

Four key attributes:

#### 1. Platform-Agnostic Compatibility

Terraform works across all major cloud providers, Azure, AWS, Google Cloud, as well as on-premise solutions. It also integrates with dozens of services like DNS, databases, container orchestration systems, and more. This flexibility makes it a strong fit for hybrid and multi-cloud environments.

#### 2. Declarative Configuration

Terraform uses a declarative language, meaning engineers describe the desired end state of infrastructure, and Terraform figures out how to get there. This is different from imperative tools (like shell scripts), where every step must be explicitly defined. Declarative syntax makes configuration easier to understand, maintain, and scale.

#### 3. Built-In State Management

Terraform maintains a “state file” to track what infrastructure has been deployed and how it has changed over time. This enables it to detect configuration drift, plan changes before applying them, and prevent conflicting updates. For organizations managing multiple environments or collaborating across teams, state management is a critical safeguard.

#### 4. Reusable Modules

Engineers can package Terraform code into reusable “modules.” A module can represent a virtual network, Kubernetes cluster, or storage account, and can be applied consistently across environments by changing only the input variables. This reduces duplication and increases consistency in deployments.

[**Further reading**](https://www.emergentsoftware.net/blog/infrastructure-as-code-why-terraform-is-the-gold-standard-for-cloud-automation/)

### Companies/industries that are using Terraform

Many, including PWC, Vodafone, and HSBC.

### Terraform connection/communication with AWS

[**Terraform documentation**](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)
