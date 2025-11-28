terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}


# Configure the GitHub Provider
provider "github" {
  token = var.github_token
}

resource "github_repository" "example" {
 name        = "terraform-test"
 description = "This is my Github repository"
 visibility  = "public"
 auto_init   = true
}