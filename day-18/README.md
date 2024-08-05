# Day 18 Task

### Problem Statement
You are tasked with deploying a three-tier web application (frontend, backend, and database) using Ansible roles. The frontend is an Nginx web server, the backend is a Node.js application, and the database is a MySQL server. Your solution should use Ansible Galaxy roles where applicable and define appropriate role dependencies. The deployment should be automated to ensure that all components are configured correctly and can communicate with each other.

## Deliverables

**1. Ansible Project Directory Structure**
Organized directory structure with roles, playbooks, inventory, and configuration files.

![alt text](<img/Screenshot from 2024-08-06 00-04-13.png>)

**2. Role Definitions and Dependencies**
meta/main.yml files for each role defining dependencies.
Customized roles with necessary configurations.

![alt text](<img/Screenshot from 2024-08-06 00-01-46.png>)

**3. Inventory File**
Inventory file defining groups and hosts for frontend, backend, and database tiers.

![alt text](<img/Screenshot from 2024-08-06 00-07-59.png>)

```ini
[app]
app-node-01 ansible_host=**.***.***.** ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/Downloads/ansible-worker.pem

[backend]
backend-01 ansible_host=**.***.***.** ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/Downloads/ansible-worker.pem

[database]
db-01 ansible_host=**.***.***.** ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/Downloads/ansible-worker.pem
```

**4. Playbook for Deployment (main.yml)**
Playbook that orchestrates the deployment of the three-tier application.

```yml
---
- name: Full Stack Application
  hosts: app
  become: yes
  tasks:
    - name: update_cache
      apt:
        update_cache: yes
  
- hosts: app
  become: true
  roles: 
    - frontend

- hosts: backend
  become: true
  roles: 
    - backend

- hosts: database
  become: true
  roles: 
    - database
```

**5. Playbook for Testing (test.yml)**
Playbook that verifies the deployment and functionality of each tier.

![alt text](<img/Screenshot from 2024-08-06 00-25-27.png>) 
![alt text](<img/Screenshot from 2024-08-06 00-25-42.png>) 
![alt text](<img/Screenshot from 2024-08-06 00-25-49.png>)

**Frontend Page**
![alt text](<img/Screenshot from 2024-08-05 23-57-33.png>)