# Project 01

## Project Steps

### 1. Setup Minikube and Git Repository

```bash
# Start Minikube
minikube start

# Create a new directory for your project
mkdir nodejs-k8s-project
cd nodejs-k8s-project

# Initialize Git repository
git init

# Create a .gitignore file
node_modules/
.env

# Add and commit initial changes
git add .
git commit -m "Initial commit"
```
![alt text](<img/project-1/Screenshot from 2024-07-17 10-40-08.png>)

### 2. Develop a Node.js Application

```bash
# Initialize the Node.js project
npm init -y

# Install necessary packages
npm install express body-parser
```

![alt text](<img/project-1/Screenshot from 2024-07-17 10-41-37.png>)

Create app.js
```js
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
```

![alt text](<img/project-1/Screenshot from 2024-07-17 10-42-11.png>)

Update package.json to include a start script
```json
"scripts": {
  "start": "node app.js"
}
```

![alt text](<img/project-1/Screenshot from 2024-07-17 10-45-03.png>)

Add and commit changes
```bash
git add .
git commit -m "Add Node.js application code"
```

![alt text](<img/project-1/Screenshot from 2024-07-17 10-49-26.png>)

### 3. Create Dockerfile and Docker Compose

Create a Dockerfile
```Dockerfile
# Use official Node.js image
FROM node:18

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port on which the app runs
EXPOSE 3000

# Command to run the application
CMD [ "npm", "start" ]
```

Create a .dockerignore file
```
node_modules
.npm
```

commit changes
```bash
git add Dockerfile
git commit -m "Add Dockerfile"
```

![alt text](<img/project-1/Screenshot from 2024-07-17 10-58-58.png>)

### 4. Build and Push Docker Image

```bash
# Build the Docker image
docker build -t nodejs-app:latest .

# Tag and push the image
docker tag nodejs-app:latest harshpatil02/nodejs-app:latest
docker push harshpatil02/nodejs-app:latest

# Add and commit changes
git add .
git commit -m "Build and push Docker image"
```

![alt text](<img/project-1/Screenshot from 2024-07-17 11-01-22.png>)

![alt text](<img/project-1/Screenshot from 2024-07-17 11-05-11.png>)

### 5. Create Kubernetes Configurations

Create kubernetes/deployment.yml:
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-app-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nodejs-app
  template:
    metadata:
      labels:
        app: nodejs-app
    spec:
      containers:
      - name: nodejs-app
        image: your-dockerhub-username/nodejs-app:latest
        ports:
        - containerPort: 3000
        env:
        - name: PORT
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: PORT
        - name: NODE_ENV
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: NODE_ENV
```

![alt text](<img/project-1/Screenshot from 2024-07-17 11-14-37.png>)

Create kubernetes/configmap.yml
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  PORT: "3000"
```

Create kubernetes/secret.yml
```yml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  NODE_ENV: cHJvZHVjdGlvbmFs # Base64 encoded value for "production"
```

```bash
# Add and commit Kubernetes configurations
git add kubernetes/
git commit -m "Add Kubernetes deployment, configmap, and secret"

# Apply the ConfigMap and Secret:
kubectl apply -f kubernetes/configmap.yaml
kubectl apply -f kubernetes/secret.yaml

# Apply the Deployment
kubectl apply -f kubernetes/deployment.yaml
```

![alt text](<img/project-1/Screenshot from 2024-07-17 11-16-06.png>)
![alt text](<img/project-1/Screenshot from 2024-07-17 11-18-22.png>)

![alt text](<img/project-1/Screenshot from 2024-07-17 12-31-56.png>)

### 6. Implement Autoscaling
Create Horizontal Pod Autoscaler

Create kubernetes/hpa.yml
```yml
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: nodejs-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nodejs-app-deployment
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
```

```bash
# Apply the HPA
kubectl apply -f kubernetes/hpa.yaml
```

![alt text](<img/project-1/Screenshot from 2024-07-17 12-37-47.png>)

### 7. Test the Deployment

Check the Status of Pods, Services, and HPA
```bash
# Verify the Pods
kubectl get pods

# Verify the Services
kubectl get svc

# Verify the HPA
kubectl get hpa

# Expose the Service
kubectl expose deployment nodejs-app-deployment --type=NodePort --name=nodejs-app-service

minikube service nodejs-app-service --url
```

![alt text](<img/project-1/Screenshot from 2024-07-17 12-40-08.png>)

![alt text](<img/project-1/Screenshot from 2024-07-17 12-39-24.png>)

# Project 02

### Project Setup

```bash
# Initialize a Git Repository
mkdir nodejs-advanced-k8s-project
cd nodejs-advanced-k8s-project
git init

# Create the initial Node.js application and Docker-related files:
npm init -y
npm install express redis body-parser
```

![alt text](<img/project-2/Screenshot from 2024-07-17 13-44-14.png>)

app.js
```js
const express = require('express');
const bodyParser = require('body-parser');
const redis = require('redis');
const app = express();
const PORT = process.env.PORT || 3000;

// Connect to Redis
const redisClient = redis.createClient({
  url: `redis://${process.env.REDIS_HOST}:${process.env.REDIS_PORT}`
});
redisClient.on('error', (err) => console.error('Redis Client Error', err));

app.use(bodyParser.json());

app.get('/', async (req, res) => {
  const visits = await redisClient.get('visits');
  if (visits) {
    await redisClient.set('visits', parseInt(visits) + 1);
  } else {
    await redisClient.set('visits', 1);
  }
  res.send(`Hello, World! You are visitor number ${visits || 1}`);
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
```

![alt text](<img/project-2/Screenshot from 2024-07-17 13-44-30.png>)

Dockerfile
```Dockerfile
FROM node:18

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
```

.dockerignore
```
node_modules
.npm
```

![alt text](<img/project-2/Screenshot from 2024-07-17 13-45-31.png>)

```bash
# Build and push Docker image:
docker build -t harshpatil02/nodejs-advanced-app:latest .
docker push harshpatil02/nodejs-advanced-app:latest
```

![alt text](<img/project-2/Screenshot from 2024-07-17 13-47-17.png>)

### 2. Advanced Kubernetes Configuration

Create `kubernetes/deployment.yaml` to deploy the Node.js
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-advanced-app-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nodejs-advanced-app
  template:
    metadata:
      labels:
        app: nodejs-advanced-app
    spec:
      containers:
      - name: nodejs-advanced-app
        image: harshpatil02/nodejs-advanced-app:latest
        ports:
        - containerPort: 3000
        env:
        - name: PORT
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: PORT
        - name: REDIS_HOST
          valueFrom:
            configMapKeyRef:
              name: redis-config
              key: REDIS_HOST
        - name: REDIS_PORT
          valueFrom:
            configMapKeyRef:
              name: redis-config
              key: REDIS_PORT
        - name: NODE_ENV
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: NODE_ENV
      - name: redis
        image: redis:latest
        ports:
        - containerPort: 6379
```

![alt text](<img/project-2/Screenshot from 2024-07-17 23-31-15.png>)

Create kubernetes/configmap.yaml to manage application and Redis configurations:
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: redis-config
data:
  REDIS_HOST: "redis"
  REDIS_PORT: "6379"
```

Create kubernetes/secret.yaml to manage sensitive environment variables:
```yml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  NODE_ENV: cHJvZHVjdGlvbg== # Base64 encoded value for "production"
```

Create kubernetes/service.yaml to expose the Node.js application:
```yml
apiVersion: v1
kind: Service
metadata:
  name: nodejs-advanced-app-service
spec:
  selector:
    app: nodejs-advanced-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
  type: NodePort
```

![alt text](<img/project-2/Screenshot from 2024-07-17 23-31-56.png>)

Create kubernetes/hpa.yaml to manage autoscaling:
```yml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: nodejs-advanced-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nodejs-advanced-app-deployment
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 70
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 30
      selectPolicy: Max
      policies:
      - type: Pods
        value: 2
        periodSeconds: 30
      - type: Percent
        value: 20
        periodSeconds: 30
    scaleDown:
      stabilizationWindowSeconds: 30
      selectPolicy: Min
      policies:
      - type: Pods
        value: 1
        periodSeconds: 30
      - type: Percent
        value: 10
        periodSeconds: 30
```

![alt text](<img/project-2/Screenshot from 2024-07-17 23-32-59.png>)

Create kubernetes/vpa.yaml to manage vertical scaling:
```yml
apiVersion: autoscaling.k8s.io/v1beta2
kind: VerticalPodAutoscaler
metadata:
  name: nodejs-advanced-app-vpa
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nodejs-advanced-app-deployment
  updatePolicy:
    updateMode: "Auto"
```

Add a Redis deployment configuration to kubernetes/redis-deployment.yaml
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: redis:latest
        ports:
        - containerPort: 6379
```
Add Redis service configuration to kubernetes/redis-service.yaml
```yml
apiVersion: v1
kind: Service
metadata:
  name: redis-service
spec:
  selector:
    app: redis
  ports:
  - protocol: TCP
    port: 6379
    targetPort: 6379
  type: ClusterIP
```

![alt text](<img/project-2/Screenshot from 2024-07-17 23-33-56.png>)

Apply Kubernetes Configurations
```bash
kubectl apply -f kubernetes/redis-deployment.yaml
kubectl apply -f kubernetes/redis-service.yaml
kubectl apply -f kubernetes/configmap.yaml
kubectl apply -f kubernetes/secret.yaml
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/hpa.yaml
kubectl apply -f kubernetes/vpa.yaml

# Check the status of your deployments and services
kubectl get all

# Access the application via Minikube
minikube service nodejs-advanced-app-service --url
```

![alt text](<img/project-2/Screenshot from 2024-07-17 17-05-35.png>)

#### Testing Scaling
Simulate load on the application to test the HPA:
```bash
kubectl run -i --tty --rm load-generator --image=busybox --restart=Never -- /bin/sh

# Inside the pod, run the following command to generate load
while true; do wget -q -O- http://nodejs-advanced-app-service; done
```

# Access the application
minikube service nodejs-advanced-app-service --url