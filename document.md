# jenkins ci/cd flow -automation
1. Checkout PHP Code

Jenkins connects to GitHub.

Downloads the latest PHP source code from the main branch.

Code is stored inside Jenkins workspace.

2. Build Docker Image

Jenkins enters project/application.

Reads the Dockerfile.

Builds a Docker image named php-app:latest.
# Jenkins CI/CD Pipeline Flow (Clear Version)

## 1. Checkout PHP Code

* Jenkins connects to GitHub.
* Downloads the latest PHP source code from the **main** branch.
* Code is stored inside Jenkins workspace.

---

## 2. Build Docker Image

* Jenkins enters `project/application`.
* Reads the `Dockerfile`.
* Builds a Docker image named **php-app:latest**.

---

## 3. Tag Docker Image for Google Artifact Registry (GAR)

* Jenkins tags the image with the GAR path:

```
<region>-docker.pkg.dev/<project-id>/<repo>/<image>:<tag>
```

Example:

```
us-central1-docker.pkg.dev/kubernetes-477004/php-app-repo/php-app:latest
```

---

## 4. Push Docker Image to GAR

* Jenkins authenticates Docker:

```
gcloud auth configure-docker
```

* Pushes the image to GAR.

---

## 5. Deploy Infrastructure using Terraform

* Jenkins enters `project/terraform`.
* Runs:

```
terraform init
terraform apply -auto-approve
```

* Terraform creates:

  * Managed Instance Group (MIG)
  * Instance Template (using new image)
  * Autoscaler
  * Application Load Balancer (ALB)
  * Firewall rules
  * Health check

---

## Full Flow Summary

1. Get code → GitHub
2. Build image → Docker
3. Tag for GAR → Add correct address
4. Push to GAR → Store image in Google Cloud
5. Deploy infra → MIG + ALB using Terraform

---




NKINS CI/CD DIAGRAM (ASCII)
 +----------------------+
 | GitHub Repo |
 +----------+-----------+
 |
 v
 +----------------------+
 | Jenkins: Checkout |
 +----------+-----------+
 |
 v
 +----------------------+
 | Build Docker Image |
 +----------+-----------+
 |
 v
 +--------------------------------------------+
 | Tag Image for Google Artifact Registry |
 +-------------------+------------------------+
 |
 v
 +-------------------------------+
 | Push Image to GAR (GCP) |
 +---------------+---------------+
 |
 v
 +---------------------------------------------+
 | Terraform Deploys MIG + ALB in GCP |
 +---------------------------------------------+
