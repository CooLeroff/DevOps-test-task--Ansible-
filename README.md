
# DevOps test task (Ansible)
This is a test task repository with using Ansible and Bash

### Tasks:

- [x] Create set of Ansible playbooks (maybe with roles) to prepare server (install docker, add needed users and implement needed security settings)
- [x] Create bash script that will do next: create backup of MongoDB database with help of mongodump and store backup on the server. Implement backup rotation: we need to store backups for 7 days only.

### Requirements:

- Ansible (ver. < 6.4.0 )  
- Ubuntu or Debian-based OS

##Actions to be taken

This playbook sets up the environment to perform the application build https://github.com/CooLeroff/DevOpsTestTask-App

The playbook consists of three roles:

- Configuring the operating system 
  - set SUDOers without password request
  - Copying MongoDB database backup bash script
  - Setting cron schedule for daily backup
- Installing Docker Engine and additional packages
- Installing and configuring GitHub Actions Runner

## How to run

1. Set variables `gh_runner_config_url` and `gh_runner_config_token `  in **main.yml** in the root folder of repository.
   For more information: https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners
2. (Recommended) Add ssh-key-host to remote host. Additional information: https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04
3. Add in file ```hosts.ini ``` the host you want to configure (There is a syntax hint in the file)
   **Please pay attention: Don`t use remote host Root user in configuration!**
4. Open terminal and run command ```ansible-playbook -i hosts.ini main.yml```

## Backup script

The `mongobackup.sh` script is located in the **roles/os_setup/files/** folder 
The Bash backup script performs the following actions:

- The docker exec command to execute the `mongodump` utility in the MongoDB container
- Removing backup files older than 7 days 

## Using variables:

Variables are defined at the beginning of the script

| BACKUP_PATH          | Путь к папке бекапов внутри контейнера          |
| -------------------- | ----------------------------------------------- |
| MONGO_CONTAINER_NAME | Container name with MongoDB                     |
| MONGO_DB_NAME        | Name of the database to be backed up            |
| MONGO_USER           | User name with access to the specified database |
| MONGO_PASSWORD       | User password                                   |
| BACKUP_NAME          | Name of the backup file to be created           |

You can use this script outside of Playbook by copying and running it manually or on a schedule

###Technical details and Environment variables

Following values are required since there is no way to register the self-hosted Runner without them:

| Name                   | Description                                        |
| ---------------------- | -------------------------------------------------- |
| gh_runner_config_url   | GitHub Repository or Organization URL              |
| gh_runner_config_token | GitHub Registration token to authenticate the host |

