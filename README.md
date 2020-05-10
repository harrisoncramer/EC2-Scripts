These scripts set up an environment for a node server running on Ubuntu 18.04 on Digital Ocean. They should be run in order. The scripts assume you are running Ubuntu 18.04, and have not configured anything on the machine. You can clone this to the machine using HTTPS, because your SSH keys will not be configured.

# setup.sh
Setup creates a user, provides the user with sudo privileges, and sets an automatic password.

# nvim.sh
After logging back in, change to user and set defualt shell to bash and configure nvim 
`Logout and log back in to reconfigure with custom password`

# shell.sh
Configures ZSH as user's shell w/ oh-my-zsh installed and agnoster theme

# node.sh
Installs nvm and node.js version 13.7.0 and sets up user to automatically use those versions
`Requires the user logout and login to reload the nvm version`

# mongodb.sh
Installs version 4.2 of mongodb and runs as a service. 
`You must subsequently configure the MongoDB server with user controlled access in /etc/mongod.conf`
Format (w/in admin db): db.createUser({ user: 'admin', pwd: 'password', roles: [{ role 'userAdminAnyDatabase', db: 'admin' }] })
Then in the /etc/mongod.conf file, uncomment #security, and below it, add the following ––> authorization: enabled
Restart Mongodb with `sudo systemctl restart mongod`

# ssh.sh
Creates a new SSH key and adds it to the ssh-agent. 
`You must manually then add this ssh key to your Github account (https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)`

# packages.sh 
This runs all of the installations necessary for a basic node.js app.
It installs Node.js, MongoDB, Yarn, PM2, and Git.

# nginx.sh

This installs and configures Nginx as a reverse proxy, sending HTTP traffic to port 3000.
The node application can then send and recieve information on that port.
