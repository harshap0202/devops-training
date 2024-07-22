#!/bin/bash

THRESHOLD_CPU=80
THRESHOLD_MEM=80

SYSTEM_METRICS() {
    echo -e "\n CPU Usage: "
    echo      "------------"
    echo "CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/")"
    echo "MEMORY_USAGE=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')"
    echo "DISK_SPACE=$(df -h / | awk '/\//{print $(NF-1)}')"

    echo -e "\n Network Stats: "
    echo      "----------------"
    echo "NETWORK_STATS=$(netstat -i)"

    echo -e "\n Top Processes: "
    echo      "----------------"
    echo "TOP_PROCESSES=$(top -bn 1 | head -n 10)"
}

LOG_ANALYSIS() {
    echo -e "\n Error Logs: "
    echo      "-------------"
    echo "ERROR_LOGS=$(grep -iE "error|critical" /var/log/syslog | tail -n 20)"

    echo -e "\n Recent Logs: "
    echo      "--------------"
    echo "RECENT_LOGS=$(tail -n 20 /var/log/syslog)"
}

HEALTH_CHECKS() {
    echo -e "\n Service Status: "
    echo      "-----------------"
    echo "SERVICE_STATUS_APACHE=$(systemctl is-active apache2)"
    echo "SERVICE_STATUS_MYSQL=$(systemctl is-active mysql)"

    echo -e "\n Connectivity: "
    echo      "---------------"
    ping -c 1 google.com >/dev/null 2>&1 && CONNECTIVITY_STATUS="Connected" || CONNECTIVITY_STATUS="Disconnected"
    echo "Connectivity Status: $CONNECTIVITY_STATUS"
}

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/")
if (( $(echo "$CPU_USAGE >= $THRESHOLD_CPU" | bc -l) )); then
    echo "High CPU usage detected: $CPU_USAGE%"
fi

MEMORY_USAGE=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')
if (( $(echo "$MEMORY_USAGE >= $THRESHOLD_MEM" | bc -l) )); then
    echo "High memory usage detected: $MEMORY_USAGE%" 
fi

REPORT_FILE="/tmp/system_report_$(date +'%Y%m%d_%H%M%S').txt"
echo "System Report $(date)" >> $REPORT_FILE
SYSTEM_METRICS >> $REPORT_FILE
LOG_ANALYSIS >> $REPORT_FILE
HEALTH_CHECKS >> $REPORT_FILE

echo "Select an option:
1. Check system metrics
2. View logs
3. Check service status
4. Exit"

read choice

case $choice in
    1) SYSTEM_METRICS
       ;;
    2) LOG_ANALYSIS
       ;;
    3) HEALTH_CHECKS
       ;;
    4) exit ;;
    *) echo "Invalid option";;
esac
