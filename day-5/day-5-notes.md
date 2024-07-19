# kubenetes

 - docker swarm is for low level applications.
  - kebernetes is for high level applications,

#### Installing Kubernetes
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version
```

#### installing minikube
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```

#### connect minikube to virtual box
```bash
minikube start --driver=virtualbox
minikube status
kubectl get nodes
```

```
kubectl -> dashboard -> kubernetes cluster  -> master node (control plane)
                                            -> worker node
```

**Kubernetes Architecture:**
 - kubectl (kube controller) - command line tool to control kubernetes
 - cli/api/dashboard - to access kubernetes
 - kubernetes cluster - contains components control plane (master node) , worker node
     - master node - api server, scheduler, controller manager are the important topics to be considered
     - worker node - controller runtime, k8s objects, are the important topics to be considered
     - cluster contains many imp things like directory to contact other nodes,
 - control plane (master node) 
     - etcd
     - controller manager - used to control the entire system
         - node controller - reposonsible to notice and respond when the nodes go down
         - job controller - keeps track of deployments (job), creates pods to completes these jobs
         - EndPointSlice controller - provides links betn services and pods
         - ServiceAccount controller - creates default serviceAccounts for new namespace
         - ...
     - api server - helps connects 2 points
     - scheduler - decides when and where in a pod a job will run
 - worker node 
     - kubelet - agent that runs a node in cluster
     - container runtime
     - 

synchronous, asynchronous



```
                                       -> service1.pod1
                                       -> service1.pod2
user -> ingress -> services - service1 -> service1.pod3
                              service2 -> service2.pod1
                                       -> service2.pod2
                                       -> service2.pod3
```



