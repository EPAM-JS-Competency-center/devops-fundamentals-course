# AWS Elastic IP Instance SSH Connectivity and Checks

## Connecting to the Instance via SSH

Connect to the AWS Elastic IP instance using SSH:

```bash
ssh -i "DevOps_for_JS_Epam_Ubuntu_instance.pem" ubuntu@34.227.126.226
```

## Checking SSH Service Status
To check the status of the SSH service on the instance, use the following command after connecting via SSH:
```bash
sudo systemctl status ssh
```

## Checking Port 22 (SSH)
To verify if port 22 (default SSH port) is open on the instance, use the following command:
```bash
nc -vz 34.227.126.226 22
```

## Checking Port Port 80 (HTTP)
Similarly, to check the availability of port 80 (HTTP), execute the following command:
```bash
nc -vz 34.227.126.226 80
```

## Checking Instance Reachability
To verify if the instance is reachable and responding to ICMP requests (ping), use the following command:
```bash
ping 34.227.126.226
```

