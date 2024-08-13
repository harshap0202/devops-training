# Day 24 Task

**Project Steps and Deliverables:**

1. **Create and Configure an S3 Bucket:**
 - Create an S3 bucket named techvista-portfolio-harshwardhan.
![alt text](<img/Screenshot from 2024-08-13 15-12-58.png>) 
 - Enable versioning on the bucket.
![alt text](<img/Screenshot from 2024-08-13 15-13-15.png>)
 - Set up the bucket for static website hosting.
![alt text](<img/Screenshot from 2024-08-13 15-36-06.png>)
 - Upload the provided static website files (HTML, CSS, images).
![alt text](<img/Screenshot from 2024-08-13 15-35-40.png>)
 - Ensure the website is accessible via the S3 website URL.

    URL -> `http://techvista-portfolio-harshwardhan.s3-website-ap-southeast-2.amazonaws.com/`

    ![alt text](<img/Screenshot from 2024-08-13 15-37-57.png>)

2. **Implement S3 Storage Classes:**
 - Classify the uploaded content into different S3 storage classes (e.g., Standard, Intelligent-Tiering, Glacier).
![alt text](<img/Screenshot from 2024-08-13 15-44-38.png>) 
![alt text](<img/Screenshot from 2024-08-13 15-44-49.png>)
 - Justify your choice of storage class for each type of content (e.g., HTML/CSS files vs. images).
     - I have set the html and css pages as standard storage class since they will be accessed regularly whenever user visits the website.
     - Whereas for images i have used the Intelligent-Tiering storage class, since they are meant to be updated regularly and display new features.

3. **Lifecycle Management:**
 - Create a lifecycle policy that transitions older versions of objects to a more cost-effective storage class (e.g., Standard to Glacier).
![alt text](<img/Screenshot from 2024-08-13 16-23-43.png>)
 - Set up a policy to delete non-current versions of objects after 90 days.
![alt text](<img/Screenshot from 2024-08-13 16-23-40.png>) 
 - Verify that the lifecycle rules are correctly applied.
![alt text](<img/Screenshot from 2024-08-13 16-22-25.png>) 

4. **Configure Bucket Policies and ACLs:**
 - Create and attach a bucket policy that allows read access to everyone for the static website content.
![alt text](<img/Screenshot from 2024-08-13 15-37-15.png>)
 - Set up an ACL to allow a specific external user access to only a particular folder within the bucket.
![alt text](<img/Screenshot from 2024-08-13 16-01-49.png>)

5. **Test and Validate the Configuration:**
 - Test the static website URL to ensure it is accessible.
![alt text](<img/Screenshot from 2024-08-13 15-37-57.png>)
![alt text](<img/Screenshot from 2024-08-13 15-58-34.png>)
