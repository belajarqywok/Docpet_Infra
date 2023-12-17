# Vercel Project Name
variable "vercel_project_name" {
    type = string
    default = "docpet-frontend"
    description = "Vercel Project Name <type: String>"
}

# Vercel Project Repo
variable "vercel_project_repo" {
    type = string
    default = "CH2-PS068/Docpet_Website"
    description = "Vercel Project Repo <type: String>"
}

# Vercel Project Domain
variable "vercel_project_domain" {
    type = string
    default = "docpet.vercel.app"
    description = "Vercel Project Domain <type: String>"
}
