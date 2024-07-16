# Kubernetes 
## (15/07)

### Basic Kubernetes Objects and Resources

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


