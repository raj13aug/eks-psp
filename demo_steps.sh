# Delete the existing default PSP and clusterrolebinding

kubectl delete podsecuritypolicy eks.privileged
kubectl delete clusterrolebinding eks:podsecuritypolicy:authenticated

# Create a new namespace for the nginx deployment demo
kubectl apply -f namespace.yaml

# Create a service account for nginx
kubectl apply -f serviceaccount.yaml

# Create the pod security policies
kubectl apply -f permissive.yaml
kubectl apply -f restrictive.yaml

# Create the roles
kubectl apply -f permissive-role.yaml
kubectl apply -f restrictive-role.yaml

# Create a restrictive rolebinding that will bind the restrictive
# policy with all service accounts in the ns-demo namespace
kubectl apply -f restrictive-nginx-rolebinding.yaml
kubectl apply -f permissive-nginx-rolebinding.yaml


# let's create an nginx deployment that does not require
# privileged access
kubectl apply -f simple-nginx-deployment.yaml
kubectl apply -f priv-nginx-deployment.yaml


# Check the status of pods, deployments and replicasets again.
# The pods should be in the 'Running' state for this deployment
kubectl get all -n ns-demo