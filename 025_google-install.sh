#!/bin/bash

mkdir -p /home/user/.workstation
cp /tmp/customize_environment /home/user/.workstation/
chown -R user:user /home/user/.workstation

mkdir -p /home/user/.gemini
cp /tmp/settings.json /home/user/.gemini
chown -R user:user /home/user/.gemini