
sudo apt-get install  supervisor virtualenv -y

virtualenv -p python3 ~/jupyter-env

source ~/jupyter-env/bin/activate
pip install jupyter
deactivate

sudo vi ~/jupyter-notebook/run-jupyter-notebook.sh
#with
#!/bin/bash
source /home/pi/jupyter-env/bin/activate
jupyter notebook --ip 0.0.0.0 --port 9999 --no-browser
deactivate

sudo chmod +x ~/jupyter-notebook/run-jupyter-notebook.sh

sudo vi /etc/supervisor/conf.d/jupyter-notebook.conf
#with
[program:jupyter-notebook]
directory=/home/pi/jupyter-notebook
command=/bin/bash -E -c ./run-jupyter-notebook.sh
autostart=true
autorestart=true
stopsignal=INT
stopasgroup=true
killasgroup=true
user=pi

sudo systemctl restart supervisor.service

#get the token with:
sudo supervisorctl
tail jupyter-notebook stdout
#web to http://[your-raspberry-pi-ip]:9999/?token=[token] in your browser








