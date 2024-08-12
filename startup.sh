#!/bin/bash

# Ensure environment variables are set
source /etc/bash.bashrc

# Pull the latest updates from Git
# git pull origin development

# Run the Python script
exec python3 recordFromEVK4.py
