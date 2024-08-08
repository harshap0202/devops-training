# Day 21 Task 

## Project Overview:
The goal of this capstone project is to combine shell scripting with system monitoring and log management practices. You will create a set of automated tools using shell scripts to manage logs, monitor system performance using Prometheus and Node Exporter, and generate insights using PromQL queries. The project will require a systematic approach, covering scripting fundamentals, log management, and monitoring setup.

## Project Deliverables:

### 1. Shell Scripts for Basic Operations:

**Task:** Write shell scripts to perform basic system operations, such as checking disk usage, memory usage, and CPU load.

**Commands:**
```bash
#!/bin/bash

LOG_FILE="logs/system_log_$(date +'%Y%m%d_%H%M%S').log"

# Check disk usage
echo "-------------------------------------------------------------------------------" >> $LOG_FILE
echo "Check disk usage" >> $LOG_FILE
echo "-------------------------------------------------------------------------------" >> $LOG_FILE
df -h >> $LOG_FILE

if [ $? -ne 0 ]; then
    echo "Error checking disk usage" >> $LOG_FILE
    exit 1
fi

# Check memory usage
echo "-------------------------------------------------------------------------------" >> $LOG_FILE
echo "Check memory usage" >> $LOG_FILE
echo "-------------------------------------------------------------------------------" >> $LOG_FILE
free -h >> $LOG_FILE

if [ $? -ne 0 ]; then
    echo "Error checking memory usage" >> $LOG_FILE
    exit 1
fi

# Check CPU load
echo "-------------------------------------------------------------------------------" >> $LOG_FILE
echo "Check CPU load" >> $LOG_FILE
echo "-------------------------------------------------------------------------------" >> $LOG_FILE
top -bn1 | grep "Cpu(s)" >> $LOG_FILE

if [ $? -ne 0 ]; then
    echo "Error checking CPU load" >> $LOG_FILE
    exit 1
fi
```

![alt text](<img/Screenshot from 2024-08-09 10-54-54.png>)

---
### 2. Log Management Script:

**Task:** Develop a script to automate log management tasks such as log rotation and archiving. This script should include the ability to compress old logs and delete logs older than a specified number of days.

**Commands:**
```bash
#!/bin/bash

# Define the output file 

OUTPUT_FILE="logs/archive/log_report.txt"

# Functions Of disk_usage , Check Memory and check CPU load
check_log() {
    echo "logs are shown below :-"
    cat /var/log/syslog | tail -n 4
    echo
}

# Write the results to the output file if specified
if [ -n "$OUTPUT_FILE" ]; then
    {
        check_log
    } > "$OUTPUT_FILE" 

    echo "Report saved to $OUTPUT_FILE"
fi
```

![alt text](<img/Screenshot from 2024-08-09 10-41-57.png>)

---
### 3. Advanced Shell Scripting - Loops, Conditions, Functions, and Error Handling:

**Task:** Refactor the previous scripts to include loops, conditionals, and functions for modularity. Implement error handling to manage potential issues during script execution.

**Commands:**
```bash
#!/bin/bash

LOG_DIR="logs"
ARCHIVE_DIR="logs/archive"
DAYS_TO_KEEP=30

# Error handling function
handle_error() {
  echo "Error on line $1"
  exit 1
}

# Trap errors
trap 'handle_error $LINENO' ERR

# Rotate and compress logs
rotate_logs() {
  for log_file in "$LOG_DIR"/*.log; do
    if [[ -f "$log_file" ]]; then
      gzip "$log_file"
      mv "$log_file.gz" "$ARCHIVE_DIR"
    fi
  done
}

# Delete old logs
delete_old_logs() {
  find "$ARCHIVE_DIR" -type f -name "*.gz" -mtime +$DAYS_TO_KEEP -delete
}

# Main function
main() {
  rotate_logs
  delete_old_logs
}
```

![alt text](<img/Screenshot from 2024-08-09 10-52-48.png>)

---
### 4. Log Checking and Troubleshooting:

**Task:** Write a script that reads through system and application logs, identifies common issues (e.g., out of memory, failed service starts), and provides troubleshooting steps based on log analysis.

**Commands:**
```bash
#!/bin/bash

SYSLOG_FILE="/var/log/syslog"
AUTH_LOG_FILE="/var/log/auth.log"

check_logs() {
    local file=$1
    local keyword=$2
    echo "Checking $file for '$keyword'..."
    grep "$keyword" "$file" | tail -n 5
}

echo "Starting log check..."
echo "System Log Errors "
check_logs $SYSLOG_FILE "error"

echo "Authentication Failures "
check_logs $AUTH_LOG_FILE "authentication failure"

echo "Log check completed."
```

![alt text](<img/Screenshot from 2024-08-09 10-53-04.png>)

---
### 5. Installation and Setup of Prometheus and Node Exporter:

**Task:** Install and configure Prometheus and Node Exporter on the system. Ensure that Node Exporter is properly configured to collect system metrics.

**Commands:**

Installing Prometheus

 - download prometheus
```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.53.1/prometheus-2.53.1.linux-amd64.tar.gz
```

 - unzip prometheus 
```bash
tar -xvf prometheus-2.53.1.linux-amd64.tar.gz
cd prometheus-2.53.1.linux-amd64/
```

 - start prometheus
```bash
./prometheus
```

![alt text](<img/Screenshot from 2024-08-08 15-35-07.png>) 

![alt text](<img/Screenshot from 2024-08-08 15-35-26.png>) 

![alt text](<img/Screenshot from 2024-08-08 15-35-58.png>) 

![alt text](<img/Screenshot from 2024-08-08 15-36-13.png>)

Installing Node Exporter

 - download node_exporter
```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
```

 - unzip node_exporter
```bash
tar -xvf node_exporter-1.8.2.linux-amd64.tar.gz
cd node_exporter-1.8.2.linux-amd64/
```

 - start node_exporter
```bash
./node_exporter 
```

![alt text](<img/Screenshot from 2024-08-08 16-52-44.png>) 

![alt text](<img/Screenshot from 2024-08-08 16-52-58.png>)

![alt text](<img/Screenshot from 2024-08-08 16-25-25.png>) 

Updating config file and adding new job in scrape_config

```yml
- job_name: "node"
  static_configs:
    - targets: ["<ip_addr>:9100"]
```

Prometheus scraping metrics from Node Exporter
![alt text](<img/Screenshot from 2024-08-08 16-27-00.png>)

---
### 6. Prometheus Query Language (PromQL) Basic Queries:

**Task:** Create a series of PromQL queries to monitor system performance, such as CPU usage, memory usage, and disk I/O.

**Commands:**

 - monitor CPU usage
```sql
rate(node_cpu_seconds_total[5m])
```
![alt text](<img/Screenshot from 2024-08-08 18-23-31.png>)

 - monitor memory usage
```sql
100 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100)
```
![alt text](<img/Screenshot from 2024-08-08 18-24-10.png>)

 - monitor disk I/O
```sql

```