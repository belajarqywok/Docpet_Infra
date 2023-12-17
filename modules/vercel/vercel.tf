# Vercel Project
resource "vercel_project" "frontend_project" {
    name = var.vercel_project_name

    git_repository = {
        type = "github"
        repo = "${var.vercel_project_repo}"
    }
}

# Vrecel Deployment
resource "vercel_deployment" "frontend_deployment" {
    project_id  = vercel_project.frontend_project.id
    production  = true
}

# Vercel Project Domain
resource "vercel_project_domain" "frontend_domain" {
    project_id = vercel_project.frontend_project.id
    domain     = var.vercel_project_domain
}
