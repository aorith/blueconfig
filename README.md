Fedora Silverblue configuration
===

> Configuration for my daily work machine running Silverblue.  
Install Ansible  

The *script* `run.sh` will:  
1. Create a python venv with the required dependencies  
2. Activate that venv and install Ansible dependencies from the file `requirements.yml`  
3. Run the main playbook  

The *playbook* only works if a proper configuration file is under `./configs/${HOSTNAME}.yml`. 

Additional manual configuration under `manual` folder.  
