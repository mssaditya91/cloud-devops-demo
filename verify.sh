#!/bin/bash
echo "✅ Verifying configuration:"

# Check Terraform configuration
echo "Checking Terraform files..."
grep -r "var\." infrastructure/ | grep -v "terraform.tfvars" && echo "Terraform variables used" || echo "No Terraform variables found"

# Check Docker versions file
echo "Checking Docker versions..."
if [ -f docker/versions.yml ]; then
  echo "Versions file found:"
  cat docker/versions.yml
else
  echo "Versions file missing"
fi

# Check Ansible configuration
echo "Checking Ansible configuration..."
grep -r "{{ " ansible/ && echo "Ansible variables used" || echo "No Ansible variables found"

# Check Kubernetes connectivity (if kubectl is configured)
echo "Checking Kubernetes cluster..."
CLUSTER_NAME=$(grep "cluster_name" infrastructure/aws-eks/terraform.tfvars | awk -F'"' '{print $2}')
if kubectl get nodes 2>&1 | grep -q "NAME"; then
  echo "Kubernetes cluster ($CLUSTER_NAME) ready"
  # Check services
  kubectl get svc nginx-service -o wide 2>&1 | grep -q "EXTERNAL-IP" && echo "NGINX service ready" || echo "NGINX service not ready"
  kubectl get pods -l app=backend 2>&1 | grep -q "Running" && echo "Backend ready" || echo "Backend not ready"
  kubectl get pods -l app=frontend 2>&1 | grep -q "Running" && echo "Frontend ready" || echo "Frontend not ready"
  kubectl get pods -l app=prometheus 2>&1 | grep -q "Running" && echo "Prometheus ready" || echo "Prometheus not ready"
else
  echo "Kubernetes cluster ($CLUSTER_NAME) not configured or not reachable"
fi
