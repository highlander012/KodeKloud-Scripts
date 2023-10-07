#!/bin/bash
yum install httpd -y
systemctl enable httpd && systemctl start httpd
cat /dev/null > /etc/logrotate.d/httpd
echo '/var/log/httpd/*_log {
    monthly
    rotate 3
    missingok
    notifempty
    sharedscripts
    create 0640 apache apache
    postrotate
        /bin/systemctl reload httpd.service > /dev/null 2>/dev/null || true
    endscript
}' | sudo tee -a /etc/logrotate.d/httpd
sudo logrotate -d /etc/logrotate.d/httpd
