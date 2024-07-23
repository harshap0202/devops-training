# Day 12 Task

#### Project Overview - Create a private git repo that has a maven project. In Jenkins create 2 freestyle project, one to compile that maven project and other to test that maven project. Create a pipeline view of the project.

---

### Step 1. Private Git Repo

#### Creating private git repo
![alt text](<img/task/Screenshot from 2024-07-23 17-01-51.png>)

Generating personal access token
![alt text](<img/task/Screenshot from 2024-07-23 17-05-04.png>)

---

#### Step 2. Compile maven project

Creating new freestyle project
![alt text](<img/task/Screenshot from 2024-07-23 17-01-29.png>)

Setting up git credentails in jenkins
![alt text](<img/task/Screenshot from 2024-07-23 17-06-59.png>)

Configuring Freestyle Project
![alt text](<img/task/Screenshot from 2024-07-23 17-07-26.png>)

Setup Maven Installation in Jenkins
![alt text](<img/task/Screenshot from 2024-07-23 17-08-55.png>)

Setup Maven Build Steps **COMPILE**
![alt text](<img/task/Screenshot from 2024-07-23 17-09-22.png>)

Build "maven-project-compile" Project
![alt text](<img/task/Screenshot from 2024-07-23 17-09-49.png>)
![alt text](<img/task/Screenshot from 2024-07-23 17-10-02.png>)

---

#### Step 3. Test maven project

Creating another Freestyle Project
![alt text](<img/task/Screenshot from 2024-07-23 17-10-34.png>)

Configuring Freestyle Project
![alt text](<img/task/Screenshot from 2024-07-23 17-12-46.png>)

Setup Maven Build Steps **TEST**
![alt text](<img/task/Screenshot from 2024-07-23 17-13-08.png>)

Build "maven-project-test" Project
![alt text](<img/task/Screenshot from 2024-07-23 17-13-37.png>) 
![alt text](<img/task/Screenshot from 2024-07-23 17-14-16.png>)

---

#### Step 4. Update Compile Project
Add the "Post-build Actions" to trigger the "maven-project-test" from "maven-project-compile"
![alt text](<img/task/Screenshot from 2024-07-23 17-15-29.png>)

---

#### Step 5. Pipeline view

Create new "build pipeline" in jenkins
![alt text](<img/task/Screenshot from 2024-07-23 17-16-36.png>)

Fill the details
![alt text](<img/task/Screenshot from 2024-07-23 17-17-16.png>)
![alt text](<img/task/Screenshot from 2024-07-23 17-17-54.png>)

Final Output
![alt text](<img/task/Screenshot from 2024-07-23 17-19-42.png>)

