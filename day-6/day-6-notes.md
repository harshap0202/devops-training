# Kubernetes 
## (15/07)

### Kubernetes Objects and Resources

 - Pods
 - ReplicaSets
 - Deployments
 - Namespaces
 - Services

### Basic Syntax

```yml
apiVersion: <api-version>
kind: <resource-kind>
metadata:
  name: <resource-name>
  namespace: <namespace>  # Optional
  labels:                  # Optional
    <label-key>: <label-value>
spec:
  <spec-field>:            # Specification fields specific to the resource type
    <subfield>: <value>
    ...
```

#### Pods: 
 - smallest and simplest Kubernetes object (single instance of a running process in the cluster)
 - Components:
   - Container
   - Storage Volumes
   - Networking

#### ReplicaSets:
 - A ReplicaSet ensures that a specified number of Pod replicas are running at any given time.
 - Maintains a stable set of replica Pods running at any given time.

#### Deployment
 - manages ReplicaSets and provides declarative updates to applications.
 - Purpose: Automates the process of scaling applications, rolling updates, and rollbacks.

#### Namespaces
 - a way to divide cluster resources between multiple users or projects
 - helps in resource isolation and organization




