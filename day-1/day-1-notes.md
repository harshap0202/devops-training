topics discussed 

8/7
topics discussed / key words
1. waterfall method pro-cons
2. agile method pro-cons
3. 


plan -> code -> build -> test -> release -> deploy -> operate -> monitor -> plan -> (loop)

1. plan - JIRA - create backlogs
     - Trello

2. code - depends on VCS - version control system
     - popular systems Git, SVN

3. build - not mandatory, depends on the app of software used
      - tools 
        - maven
        - gradle
        - CMARE
        - ANT
        - etc.

4. testing - not mandatory but recommended
        - eg integration test, unit test
        - tools 
          - Selenium
          - Appium
          - Junit, Qunit
          - etc.

5. release - binds everything together 
        - pipeline
        - tools
          - jenkins
          - bitbucket
          - gitlab workflows
          - bamboo
          - hudson
          
6. deploy - create environment for creating app and making availbale for users
          - tools 
            - dokcer 
            - D container
            - Vagrant

7. operation - part 1 - 
          - part 2 - operation / automation
           
8. monitor - keep track if the app is working as expected or not
        - continuous monitoring
        - tools
          - prometheus 
          - grafana
          
Linux
least resource intensive os, 
secure,       



gui & cli 
mostly used cli
ssh - linux 
rdp - win
powershell - win & bash - linux

ssh <username>@<IP>

piering - used to connect two devices connected to different networks
public ip - alternate and most important



commands 
 - lsblk
 - mkfs
 - df
 - mount

practicals

 - run a simple shell program to create and copy files

 - creating ec2 instance and attaching a volume to it

 - host a static website using ec2 instance and apache2
    steps 
    1. create ec2 instance on aws with linux ami
    2. set the inbound rule to allow ssh (22) and http (80)
    3. in the instance first run `sudo apt-get update`
    4. next run the command to install apache2 `sudo apt install apache2`
    5. once installation is complete go to the apache main directory `cd /var/www/html`
    6. create a directory here to store the html, css, js files `mkdir new-site && cd new-site`
    7. in this directory create the website pages
    8. now use the 
