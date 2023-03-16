Post-install
===

> Ansible playbook and scripts  

The *script* [run.sh](run.sh) will:  
1. Create a python venv with the required dependencies  
2. Activate that venv and install Ansible dependencies from the file [requirements.yml](requirements.yml)  
3. Run the main playbook  

The *playbook* only works if a proper configuration file exists in [configs/${HOSTNAME}.yml](configs).  

Additional manual configuration lives under the [manual](manual) folder.  
