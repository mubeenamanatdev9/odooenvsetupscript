#!/bin/bash

# Prompt for the environment name
read -p "Enter the environment name: " ENV_NAME

read -p "Enter the Odoo Version: " odoo

read -p "Enter the Python Version: " python_version

read -p "Enter the Community(c) or Enterprise(e): " src_type

odoo_version="odoo${odoo}"
# Create a virtual environment
virtualenv -p python$python_version "$odoo_version/env/$ENV_NAME"

# Debug: Print the path to the virtual environment
echo "Virtual environment created at: $odoo_version/env/$ENV_NAME"

# Attempt to activate the virtual environment
source "$odoo_version/env/$ENV_NAME/bin/activate"

if [[ $src_type -eq 'c' ]]
then
    echo "Odoo Community Source Has been selected"
   pip3 install -r "$odoo_version/src/odoo/requirements.txt"
  
elif [[ $src_type -eq 'e' ]]
then
   echo "Odoo Enterprise Source Has been selected" 
   pip3 install -r "$odoo_version/src/odoo_${odoo}_ent/requirements.txt"
fi

"$odoo_version/src/odoo/odoo-bin" -sc "$odoo_version/env/$ENV_NAME/config/config.conf"
