# Project 02

## Objective: Automate the deployment and configuration of a multi-tier web application stack consisting of:

1. Database Server: Set up a MySQL database server on one Ubuntu instance.

2. Application Server: Set up a web server (e.g., Apache or Nginx) on another Ubuntu instance to host a web application.

3. Application Deployment: Ensure the web application is deployed on the application server and is configured to connect to the MySQL database on the database server.

4. Configuration Management: Use Ansible to automate the configuration of both servers, including the initialization of the database and the deployment of the web application.

## Deliverables

1. Ansible Inventory File
 - inventory.ini
 ```ini
[database]
db_server-01 ansible_host=**.***.***.*** ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/Downloads/ansible-worker.pem

[app]
app-server-01 ansible_host=**.***.***.*** ansible_user=ubuntu ansible_ssh_private_key_file=/home/einfochips/Downloads/harsh.pem
 ```

![alt text](<../img/Screenshot from 2024-08-01 16-11-04.png>)

2. Ansible Playbook
 - Filename: deploy_multitier_stack.yml
 - Content: Automates:
     - The deployment and configuration of the MySQL database server.
     - The setup and configuration of the web server.
     - The deployment of the web application and its configuration to connect to the database.

```yml
- name: Set up application server
  hosts: app
  become: yes

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Start and enable Nginx service
      systemd:
        name: nginx
        state: started
        enabled: yes

    - name: Copy application files
      copy:
        src: files/index.html
        dest: /var/www/html/index.html

  handlers:
    - name: Reload Nginx
      service:
        name: nginx
        state: reloaded
# -----------------------------------------------------
- name: setup Mysql with database db and remote login
  become: yes
  hosts: database

  vars: 
    db_user: user
    db_pass: pass
    db_name: my_db
  
  tasks:
    - name: Installing Mysql  and dependencies
      package:
       name: "{{item}}"
       state: present
       update_cache: yes
      loop:
       - mysql-server
       - mysql-client 
       - python3-mysqldb
       - libmysqlclient-dev
      become: yes

    - name: start and enable mysql service
      service:
        name: mysql
        state: started
        enabled: yes

    - name: creating mysql user
      mysql_user:
        name: "{{db_user}}"
        password: "{{db_pass}}"
        priv: '*.*:ALL'
        host: '%'
        state: present

    - name: creating database
      mysql_db:
        name: "{{db_name}}"
        state: present
# -----------------------------------------------------
- name: Connect Webserver to database
  hosts: app
  become: yes
  tasks:
    - name: Configure application
      template:
        src: templates/app_config.php.j2
        dest: /var/www/html/app_config.php
```

3. Jinja2 Template
 - Filename: templates/app_config.php.j2

```j2
<?php
$db_host = "{{ database }}";
$db_name = "{{ my_db }}";
$db_user = "{{ user }}";
$db_pass = "{{ pass }}";

$conn = new mysqli($db_host, $db_name, $db_pass, $db_name);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

echo "Connected successfully";
?>

```

4. Application Files
 - Filename: files/index.html

```html
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to My Web Application</title>
</head>
<body>
    <center>
        <h1>Hello World!</h1>
        <p>This is a basic web application setup using Ansible.</p>
        <p>Day-17 | Project-2</p>
    </center>
</body>
</html>
```


**Final Output**
![alt text](<../img/Screenshot from 2024-08-01 16-45-12.png>)
![alt text](<../img/Screenshot from 2024-08-01 16-45-24.png>)

**Webpage Running**
![alt text](<../img/Screenshot from 2024-08-01 16-50-58.png>)

**MySQL and User Created**
![alt text](<../img/Screenshot from 2024-08-01 16-52-22.png>)
