##**LAB 2.**

###**Part 1. Installing and configuring remote OS on VBox.**

1. install some OS, that differs from your host&#39;s one. Better if it will be Ubuntu/Linux. For this you can use provided on EPAM confluence [instructions](https://kb.epam.com/display/EPMLOCALIT/Virtual+Machine+creation+using+Oracle+VM+VirtualBox) about how to install and set up [official EPAM Ubuntu image](https://kb.epam.com/display/EPMLOCALIT/How+to+deploy+EPAM+Ubuntu+image+%28automatically%29+to+a+virtual+machine).
2. **Win10** deploying Ubuntu OS on VBox **tips** and **troubleshooting** :
    - System Requirements for Ubuntu 18/20:
    - 2 GHz dual-core processor;
    - 4 GiB RAM (but 1 GiB can work);
    - 25 GB of hard-drive space;
    - VGA capable of 1024×768 screen resolution;
    - In case installation takes too long, or at some point screen frozen, or any actions are not performed, stop running session, go to setting and try to increase base memory and processors count, then restart VM;
    - In some cases, it is helpful to disable **Virtual Machine Platform** Windows feature;
    - Also, it is possible for testing purposes to use Ubuntu iso from [official site](https://ubuntu.com/download/desktop) instead EPAM&#39;s iso, as last takes too much more time for installation and running, then official one;

3. In installed VBox OS install openSSH server.
4. Allow incoming SSH connections and common ports **22** and **80** by configuring the [Uncomplicated Firewall](https://help.ubuntu.com/community/UFW) (next UFW).
5. The SSH connection to a VM can be by configuring Networking of VM. There are [a lot of options](https://technology.amis.nl/platform/virtualization-and-oracle-vm/virtualbox-networking-explained/) for it, but for this Lab configure the following:
    1) via setup NAT [port forwarding](https://www.virtualbox.org/manual/ch06.html#natforward);
    
    2) via Host Only with using VM&#39;s IP address.

6. Now try to SSH to remote OS via NAT and Host Only adapters. Also, ping the VM&#39;s OS by IP from host OS to make sure it&#39;s accessible from outside.
7. [**optional**] configure static IP address for your server.

###**Part 2. Preparing Back-End &amp; Front-End apps.**

1. For further work you will need 2 apps: Front-End app and Back-End for it. You can use your personal REST API server and related single page app (SPA) if you want. Or there is possibility to use already existing ones, from the repositories of [EPAM JS Competency Center](https://github.com/EPAM-JS-Competency-center).
2. Set up [Back-end app](https://github.com/EPAM-JS-Competency-center/nestjs-rest-api/tree/feat/products-api):
    1. Make sure you are on or checkout to branch _**feat/products-api**_.
    2. Store and use the following [_environmental_](https://en.wikipedia.org/wiki/Environment_variable) [_variables_](https://nodejs.org/dist/latest-v8.x/docs/api/process.html#process_process_env):
       1. **APP\_PORT** – define an application port on which your server will keep connection and handle requests. E.g., 8080.
       2. **NODE\_ENV** – identifies current application&#39;s environment.
       3. **ENV\_CONFIGURATION** – identifies a name of current configuration that application server must use (if any).
    3. Add a necessary [npm script(s)](https://docs.npmjs.com/cli/v7/using-npm/scripts) to start your server. In case using existing app from Competency Center set up project to use described variables.
    4. Setup CORS rules to allow and accept client&#39;s app requests.
    5. Use either [nodemon](https://www.npmjs.com/package/nodemon) or [pm2](https://www.npmjs.com/package/pm2) **to start/re-start** your app (and track when source code is changed).
9. Setup client app (choose shop app with framework you&#39;d prefer more) **:**
    1. **Connect** client app with API, by add necessary actual URLs in client app (for Angular modify environments files) to make FE app sends requests to NodeJS REST API, which you have just configured.
11. Check that data requested and displayed successfully and all CRUD operations (implemented in app) working well, by running and testing both apps.

###**Part 3. Nginx setup.**

1. [Download](https://nginx.org/en/download.html), [install](https://nginx.org/en/docs/install.html) ([Windows installation](https://nginx.org/en/docs/windows.html)) and [configure](http://nginx.org/en/docs/beginners_guide.html) [Nginx](https://nginx.org/) on your workstation or laptop.
2. Implement Nginx configuration which will [serve](https://docs.nginx.com/nginx/admin-guide/web-server/serving-static-content/) FE application and necessary assets. You can use and setup provided template of _**nginx configuration**_ file in the _nginx_ folder. 
   In that file located already prepared templated for servers, but partially used placeholders for some paths and configurations.
3. Implement Nginx configuration which will proxy requests from client app to REST API server so that API requests, which are made from client app’s, are proxied and redirected to server's host and port. Eventually your application must seem working on one port. Two apps are managed by Nginx. You should have configurations for:
    1. local debugging/development (front-end and back-end are running apps);
    2. static client files with proxied requests to server;
    3. https connection with provided SSL certificates;
    4. redirection from http to https.
4. **[optional]** Add [_gzip_](https://en.wikipedia.org/wiki/Gzip) [_compression_](https://docs.nginx.com/nginx/admin-guide/web-server/compression/) for static content.

###**Part 4. Configure SSH.**

1. Connect to installed OS in VBox via [SSH](https://www.ssh.com/ssh/) using username and IP of machine.
2. [Create a new user](https://aws.amazon.com/premiumsupport/knowledge-center/new-user-accounts-linux-instance/) with **root** privileges:  **username** : _sshuser_, **password** : _sshpassword_ .
3. Setup SSH connection using SSH keys, which providing a secure way of logging to remote servers, without using passwords.
4. Setup SSH alias by modifying **~/.ssh/config** on your host OS.

###**Part 5. Starting and serving BE &amp; FE apps on remote OS.**

1. Make sure that on remote Ubuntu OS installed **nvm** , **node** and **nginx**.
2. Using cli/shell tools and [SCP](https://linuxhint.com/linux_scp_command) (NOTE: [_here_](https://winscp.net/eng/index.php) is windows analogue. [_Here_](https://www.computerhope.com/unix/scp.htm#copying-files) and [_here_](https://tecadmin.net/download-file-using-ssh) are some useful topics about Secure Copy tool) tool upload your **built apps** (server and client) files, **package.json** from server app, **nginx config**, **certificates**, etc. to Ubuntu OS. Pay attention, that applications files are in right places:
    1. /var/www/ - client files
    2. /var/app/ - server files
    3. /etc/nginx/sites-available/ – nginx configuration

    >Note: if the folders do not exist in the destination, you should create them firstly and set rights for allowing your user to perform operations or change the owner group for created folders.To handle all these actions in one place – better to create script for simplicity and place all needed commands there (see example script in attachments), so when some source files changed you may easily rebuild the apps and update them on VM.

3. Once copying of files is done, setup apps in the Ubuntu: run server app, replace paths in your _**nginx configuration**_ file, to make them in accordance with new files locations. Then activate your nginx.config by creating a symbolic link between the _sites-available/_ directory and the _sites-enabled/_ directories (if default nginx server block override your custom nginx config – delete it).

4. Finally, check your apps are running on **80** or **443** port from your host OS. 
   >NOTE: use Host-only IP address of VM instance.

5. Organize a flow (using shell scripts or provide README with instructions) of apps re-deployment after code is changed.

##**Independent work**

**Task 1.** Change/Add nginx configuration, so the requests from client app, which is being run on your host machine, will be proxied to REST API running on remote Ubuntu OS. So, both client applications (on host and on Ubuntu VM) are sending requests to one server.

**[OPTIONAL]Task 2.** Configure your server to keep NodeJS REST API app running, after SSH disconnection:

- [https://www.howtogeek.com/howto/ubuntu/keep-your-ssh-session-running-when-you-disconnect/](https://www.howtogeek.com/howto/ubuntu/keep-your-ssh-session-running-when-you-disconnect/)
- [https://devdojo.com/ize\_cubz/how-to-keep-nodejs-app-running-after-ssh-connection-is-closed](https://devdojo.com/ize_cubz/how-to-keep-nodejs-app-running-after-ssh-connection-is-closed)
- [https://www.virtualbox.org/manual/ch07.html](https://www.virtualbox.org/manual/ch07.html)

**[OPTIONAL] Task 3**: Run an instance in AWS/Azure/GCP or [select another preferred Cloud Provider](https://www.supereasy.com/100-free-6-best-cloud-service-providers/) and try to setup apps in the same way as was described for the local Ubuntu VM, but on that cloud instance.
