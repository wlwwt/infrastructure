terraform {
  backend "remote" {
    organization = "nexton"

    workspaces {
      name = "nexton-infrastructure"
    }
  }
}
