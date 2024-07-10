# Part 1: Creating and Editing Text Files
Scenario: You are tasked with documenting the configurations and settings for a new server. You'll use different text editors to create and update these documents.

### 1. Using Nano

Create a file server_config.txt using Nano:

`nano server_config.txt`

Add the following content:

```bash
Server Name: WebServer01
IP Address: 192.168.1.100
OS: Ubuntu 20.04
```
Save and exit (Ctrl+O, Enter, Ctrl+X).

![alt text](<img/Screenshot from 2024-07-09 12-13-04.png>)


### 2. Using Vi

Edit the same file with Vi:

`vi server_config.txt`

Append the following text:

```
Installed Packages: Apache, MySQL, PHP
```
Save and exit (Esc, :wq).

![alt text](<img/Screenshot from 2024-07-09 12-13-44.png>)
        
### 3. Using Vim

Further edit the file with Vim:

`vim server_config.txt`

Add the following text:

```
Configuration Complete: Yes
```

Save and exit (Esc, :wq).

![alt text](<img/Screenshot from 2024-07-09 12-14-24.png>)

---
# Part 2: User & Group Management
Scenario: You need to set up user accounts and groups for a new team joining the project.

### 1. Adding/Removing Users

```bash
# Add a new user developer:
sudo adduser developer

# Remove the user developer:
sudo deluser developer
```

![alt text](<img/Screenshot from 2024-07-09 21-50-05.png>)

### 2. Managing Groups

```bash
# Create a group devteam:
sudo groupadd devteam

# Add the user developer to the devteam group:
sudo usermod -aG devteam developer

# Remove the user developer from the devteam group:
sudo gpasswd -d developer devteam
```

![alt text](<img/Screenshot from 2024-07-09 21-56-02.png>)

---
# Part 3: File Permissions Management 
Scenario: Ensure that only the appropriate users have access to specific files and directories.

### 1. Understanding File Permissions
View permissions for server_config.txt:

`ls -l server_config.txt`

![alt text](<img/Screenshot from 2024-07-09 22-11-09.png>)

Here the output **-rw-rw-r--** can be interpreted as follows
 - the **-** denotes that listed object is a file, if its a directory it would have be marked with **d**
 - first **rw-** means the user has permission to read and write
 - second **rw-** means the group has permission to read and write
 - third **r--** means the others have the permission the read only

### 2. Changing Permissions and Ownership

```bash
# Change permissions to read/write for the owner and read-only for others:
chmod 644 server_config.txt

# Verify the change:
ls -l server_config.txt

# Change the owner to developer and the group to devteam:
sudo chown developer:devteam server_config.txt

# Verify the change:
ls -l server_config.txt
```

![alt text](<img/Screenshot from 2024-07-09 22-13-09.png>)

---
# Part 4: Controlling Services and Daemons

Scenario: Manage the web server service to ensure it is running correctly and starts on boot.

### 1. Managing Services with systemctl

```bash
# Start the Apache service:
sudo systemctl start apache2

# Stop the Apache service:
sudo systemctl stop apache2

# Enable the Apache service to start on boot:
sudo systemctl enable apache2

# Disable the Apache service:
sudo systemctl disable apache2

# Check the status of the Apache service:
sudo systemctl status apache2
```

![alt text](<img/Screenshot from 2024-07-09 22-16-11.png>)

### 2. Understanding Daemons
Discuss the role of the sshd daemon in providing SSH access to the server.

---
# Part 5: Process Handling

Scenario: Monitor and manage processes to ensure the server is performing optimally.

### 1. Viewing Processes

```bash
# List all running processes:
ps aux

# Use top to view processes in real-time:
top
```

![alt text](<img/Screenshot from 2024-07-09 22-18-55.png>)

![alt text](<img/Screenshot from 2024-07-09 22-19-47.png>)

### 2. Managing Processes

```bash
# Identify a process to kill using ps or top, then kill it:
kill <PID>

# Change the priority of a process (e.g., running sleep with a lower priority):
nice -n 10 sleep 100 &

# Change the priority of the process using renice:
renice +10 <PID>
```

![alt text](<img/Screenshot from 2024-07-09 22-24-30.png>)

---
# Creating and Deploying a Static Website with Apache2
Activity Breakdown

## Part 1: Installing Apache2 (5 minutes)

1. Update Package Lists
    Open the terminal and run:
    ```bash
    sudo apt update
    ```

2. Install Apache2
    Install Apache2 by running:
    ```bash
    sudo apt install apache2
    ```

3. Start and Enable Apache2
    ```bash
    # Start the Apache2 service:
    sudo systemctl start apache2

    # Enable Apache2 to start on boot:
    sudo systemctl enable apache2
    ```

4. Verify Installation
    Open a web browser and navigate to http://your_server_ip. You should see the Apache2 default page.

## Part 2: Creating the Website (10 minutes)

1. Navigate to the Web Directory
    Change to the web root directory:
    ```bash
    cd /var/www/html
    ```

2. Create a New Directory for the Website
    ```bash
    # Create a directory named mystaticwebsite:
    sudo mkdir mystaticwebsite

    # Change ownership of the directory:
    sudo chown -R $USER:$USER /var/www/html/mystaticwebsite
    ```

3. Create HTML File
    Create and edit the index.html file:

    ```bash
    nano /var/www/html/mystaticwebsite/index.html
    ```

    Add the following content:

    ```html
    <!DOCTYPE html>
    <html>
    <head>
      <title>My Static Website</title>
      <link rel="stylesheet" type="text/css" href="styles.css">
    </head>
    <body>
      <h1>Welcome to My Static Website</h1>
      <p>This is a simple static website using Apache2.</p>
      <script src="script.js"></script>
    </body>
    </html>
    ```
    Save and exit (Ctrl+O, Enter, Ctrl+X).

4. Create CSS File
    Create and edit the styles.css file:
    ```bash
    nano /var/www/html/mystaticwebsite/styles.css
    ```


    Add the following content:
    ```css
    body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      text-align: center;
      margin: 0;
      padding: 20px;
    }

    h1 {
      color: #333;
    }
    ```
    Save and exit (Ctrl+O, Enter, Ctrl+X).

5. Create JavaScript File
    Create and edit the script.js file:
    
    ```bash
    nano /var/www/html/mystaticwebsite/script.js
    ```

    Add the following content:
    
    ```js
    document.addEventListener('DOMContentLoaded', function() {
      console.log('Hello, World!');
    });
    ```
    
    Save and exit (Ctrl+O, Enter, Ctrl+X).

6. Add an Image
    Download or copy an image file (e.g., logo.png) to the website directory:

    ```bash
    cp /path/to/your/logo.png /var/www/html/mystaticwebsite/logo.png
    ```

    Update index.html to include the image:

    ```html
    <body>
      <h1>Welcome to My Static Website</h1>
      <img src="logo.png" alt="Logo">
      <p>This is a simple static website using Apache2.</p>
      <script src="script.js"></script>
    </body>
    ```


### Part 3: Configuring Apache2 to Serve the Website (10 minutes)
1. Create a Virtual Host File
    Create and edit the virtual host configuration file:
    
    ```bash
    sudo nano /etc/apache2/sites-available/mystaticwebsite.conf
    ```
    Add the following content:

    ```html
    <VirtualHost *:80>
      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/html/mystaticwebsite
      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>
    ```
    Save and exit (Ctrl+O, Enter, Ctrl+X).

2. Reload Apache2 & Test the Configuration
    ```bash
    # Enable the virtual host configuration:
    sudo a2ensite mystaticwebsite.conf

    # Disable the default site configuration:
    sudo a2dissite 000-default.conf

    # Reload the Apache2 service to apply the changes:
    sudo systemctl reload apache2
    ```

3. Final Output
    ![alt text](<img/Screenshot from 2024-07-09 22-49-52.png>)




