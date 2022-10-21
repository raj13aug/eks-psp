# Create a new namespace for the nginx deployment demo
kubectl apply -f namespace.yaml

# Create a service account for nginx
kubectl apply -f serviceaccount.yaml

# Create the pod security policies
kubectl apply -f psps/permissive.yaml
kubectl apply -f psps/restrictive.yaml

# Create the roles
kubectl apply -f roles/permissive-role.yaml
kubectl apply -f roles/restrictive-role.yaml

# Create a restrictive rolebinding that will bind the restrictive
# policy with all service accounts in the ns-demo namespace
kubectl apply -f restrictive-nginx-rolebinding.yaml


# Now, let's create an nginx deployment that does not require
# privileged access
kubectl apply -f simple-nginx-deployment.yaml

# Check the status of pods, deployments and replicasets. The pods
# should be in the 'Running' state for this deployment
kubectl get all -n ns-demo

# Next, let's create another nginx deployment, that requires
# access to the hostNetwork
kubectl apply -f priv-nginx-deployment.yaml

# Check the status of the pods, deployments and replicasets.
# You will notice that there are no pods listed for this
# deployment. Describe the corresponding replicaset to
# know the reason behind this
#kubeclt -n ns-demo describe rs <priv_RS_NAME>

# Now, let's create a rolebinding that will provide access
# to the permissive pod security policy to the nginx service
# account
kubectl apply -f permissive-nginx-rolebinding.yaml

# Check the status of pods, deployments and replicasets again.
# The pods should be in the 'Running' state for this deployment
kubectl get all -n ns-demo