# creating a jenkins freestyle pipeline to compile and run maven project

first set up the maven installation in the jenkins tools

then create a new freestyle project in jenkins and add the git repo of the maven project
![alt text](<img/notes/Screenshot from 2024-07-23 14-12-59.png>)

create a build step "Invoke top-level Maven targets" 
![alt text](<img/notes/Screenshot from 2024-07-23 14-13-38.png>)

build the project for first time, it will download the needed maven plugins listed in pom.xml
![alt text](<img/notes/Screenshot from 2024-07-23 14-17-45.png>) 
![alt text](<img/notes/Screenshot from 2024-07-23 14-18-21.png>)


# creating a "pipeline view" of the freestyle projects

 - install plugin "build pipeline" in jenkins
 - in the dashboard, click on the plus button to create a new view
 - add a name and select "build pipeline view"

fill the details as shown below - 

### Pipeline Flow
 - Layout -> `Based on upstream/downstream relationship`
     - Select Initial Job -> `build-1` [the first job that starts the other]

### Trigger Options
 - Build Cards -> `Standard build card`
 - Restrict triggers to most recent successful builds -> `Yes`
 - Always allow manual trigger on pipeline steps -> `Yes`

### Display Options
 - No Of Displayed Builds -> `5` [any number you wish]
 - Row Headers -> `All build variables and parameters`
 - Column Headers ->`All build variables and parameters`
 - Refresh frequency (in seconds) -> `10`
 - Console Output Link Style -> `Lightbox`

