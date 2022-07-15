### Lab 2: Networking & Security. Web Servers.

**Pre-requisites**:

1.	A VM is set up, and a Linux distribution is configured.
2.	GitHub repository (public or private) is created. There you might store your solutions, files, artifacts relative to the program’s labs.
3.	If necessary, share access to your repo with a mentor, an expert, or another person who will evaluate your work or help to solve issues.

#### Part 1. Installing and configuring remote OS on VBox.

1. Install [openSSH](https://www.openssh.com/) server in your Linux distribution.
2. Allow incoming SSH connections and common ports (**22** and **80**) by configuring the [Uncomplicated Firewall](https://help.ubuntu.com/community/UFW) (UFW).
3. Establish the SSH connection to a Linux OS by configuring [Networking](https://technology.amis.nl/platform/virtualization-and-oracle-vm/virtualbox-networking-explained/) of respective VM. For this lab we recommend use the following approaches:
    1) via setup NAT [port forwarding](https://www.virtualbox.org/manual/ch06.html#natforward);
    2) via Host Only with using VM&#39;s IP address.
4. Ping the Linux by IP from your host OS to make sure that configuration of Networking is done correctly, and OS accessible from outside.
5. [**optional**] configure static IP address for your Linux distribution.

#### Part 2. Configure SSH. 

1. Connect to configured Linux VM via [SSH](https://www.ssh.com/ssh/) using username and IP of VM (use NAT or Host Only adapter's IP).
2. [Create a new user](https://aws.amazon.com/premiumsupport/knowledge-center/new-user-accounts-linux-instance/) with _**root**_ privileges:
   > **username** : _sshuser_
   > 
   > **password** : _sshpassword_
3. Modify _**/etc/ssh/sshd_config**_ allowing ssh-connection only for **sshuser**.
4. On a local machine generate a new ssh-key.
5. Add a public key to the Linux OS for **sshuser**.
6. Connect to the VM's OS via SSH using this public key.
7. Setup SSH alias by modifying **~/.ssh/config** on your host OS. And SSH to Linux using command:
            ```
            ssh <your_alias>
            ```
8. Install the [screen](https://ma.ttias.be/screen-a-must-for-ssh/) utility ([here](https://www.youtube.com/watch?v=Mw6QvsChxo4) and/or [here](https://www.youtube.com/watch?v=I4xVn6Io5Nw) you can find a short video on how to use it).
Play with the screen (create screens, detach/attach it, split terminal window, etc.) while you connected to the remote host via SSH.
9. [**optional**] Investigate the [SSH tunneling](https://www.ssh.com/academy/ssh/tunneling) feature ([here](https://goteleport.com/blog/ssh-tunneling-explained/) you can find some additional info). Consider use cases of it.
For which tasks or operations this approach would be handy for you.

#### Part 3. Preparing Back-End &amp; Front-End apps.

1. For further work you will need 2 apps: Front-End app and Back-End for it. You can use your personal REST API server and related single page application (SPA) or there is possibility to use already existing ones, from the repositories of [EPAM JS Competency Center](https://github.com/EPAM-JS-Competency-center) ([nestjs-rest-api](https://github.com/EPAM-JS-Competency-center/nestjs-rest-api), [shop-angular](https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront), [shop-vue-vuex](https://github.com/EPAM-JS-Competency-center/shop-vue-vuex-cloudfront), [shop-react-redux](https://github.com/EPAM-JS-Competency-center/shop-react-redux-cloudfront))
2. Set up **Back-End app**:
    1. Make sure you are on or checkout to branch _**feat/products-api**_.
    2. Store and use the following [_environmental_](https://en.wikipedia.org/wiki/Environment_variable) [_variables_](https://nodejs.org/dist/latest-v8.x/docs/api/process.html#process_process_env):
       1. **APP\_PORT** – define an application port on which your server will keep connection and handle requests. E.g., 8080.
       2. **NODE\_ENV** – identifies current application&#39;s environment.
       3. **ENV\_CONFIGURATION** – identifies a name of current configuration that application server must use (if any).
    3. Add a necessary [npm script(s)](https://docs.npmjs.com/cli/v7/using-npm/scripts) to start your server. In case using existing app from Competency Center set up project to use described variables.
    4. Setup CORS rules to allow and accept client&#39;s app requests.
    5. Use either [nodemon](https://www.npmjs.com/package/nodemon) or [pm2](https://www.npmjs.com/package/pm2) **to start/re-start** your app (and track when source code is changed).
9. Setup **Front-End app** (choose shop app written on framework you'd prefer more) **:**
    1. **Connect** client app with API, by add necessary actual URLs in client app (for Angular modify environments files) to make FE app sends requests to NodeJS REST API, which you have just configured.
11. Check that data requested and displayed successfully and all CRUD operations (implemented in app) working well, by running and testing both apps.

#### Part 4. Nginx setup.

1. [Download](https://nginx.org/en/download.html), [install](https://nginx.org/en/docs/install.html) ([Windows installation](https://nginx.org/en/docs/windows.html)) and [configure](http://nginx.org/en/docs/beginners_guide.html) [Nginx](https://nginx.org/) on your workstation or laptop.
2. Implement Nginx configuration which will [serve](https://docs.nginx.com/nginx/admin-guide/web-server/serving-static-content/) FE application and necessary assets. In the [nginx folder](./nginx) you can find examples of templates for servers, with placeholders instead paths and some others configurations.
3. Setup Nginx server to proxy requests from client app to REST API server so that API requests, which are made from client app’s, are proxied and redirected to server's host and port. 
   Eventually your application must seem working on one port. Two apps are managed by Nginx. 
   In result you should have configurations for:
    1. local debugging/development (front-end and back-end are locally running apps);
    2. static client files with proxied requests to server;
    3. https connection with provided SSL certificates;
    4. redirection from http to https.
4. **[optional]** Add [_gzip_](https://en.wikipedia.org/wiki/Gzip) [_compression_](https://docs.nginx.com/nginx/admin-guide/web-server/compression/) for static content.

#### Part 5. Starting and serving BE &amp; FE apps on remote OS.

1. Using cli/shell tools and [SCP](https://linuxhint.com/linux_scp_command) (NOTE: [_here_](https://winscp.net/eng/index.php) is windows analogue. [_Here_](https://www.computerhope.com/unix/scp.htm#copying-files) and [_here_](https://tecadmin.net/download-file-using-ssh) are some useful topics about Secure Copy tool)
   upload your **built apps** (server and client) files as well as other necessary files for their installation and running (package.json, configs, certificates etc.) to remote Linux OS. Pay attention, it's recommended to place applications files in next locations:
         
      | Location | Files |
      | -------- | ----- |
      | /var/www/ | client |
      | /var/app/ | server |
      | /etc/nginx/sites-available/ | nginx configuration |

2. After transferring files, setup apps in the remote Linux OS:
   1. run server app;
   2. run and configure the Nginx server, to make it work in accordance with new locations and other settings of remote OS.
3. Finally, check your apps are running on **80** or **443** of your Linux distribution's port from your host OS. 
   >NOTE: use Host-only IP address of VM instance to access application from outside of VM.
4. Organize a flow (using shell scripts) of apps re-deployment after code is changed. [Here](./scripts/ssh_deploy-apps.sh) is example of script, which builds and transfers files via SSH.

### Independent work

**Task 1.** Change/add Nginx configuration, so the requests from client app, which is being run on your host machine, will be proxied to REST API running on remote OS. So, both client applications (on host and on VM's OS) are sending requests to one server.

**[OPTIONAL] Task 2.** Configure your server to keep NodeJS REST API app running, after SSH disconnection:

- [https://www.howtogeek.com/howto/ubuntu/keep-your-ssh-session-running-when-you-disconnect/](https://www.howtogeek.com/howto/ubuntu/keep-your-ssh-session-running-when-you-disconnect/)
- [https://devdojo.com/ize\_cubz/how-to-keep-nodejs-app-running-after-ssh-connection-is-closed](https://devdojo.com/ize_cubz/how-to-keep-nodejs-app-running-after-ssh-connection-is-closed)
- [https://www.virtualbox.org/manual/ch07.html](https://www.virtualbox.org/manual/ch07.html)

**[OPTIONAL] Task 3**: Run an instance in AWS/Azure/GCP or [select another preferred Cloud Provider](https://www.supereasy.com/100-free-6-best-cloud-service-providers/) and try to setup apps on that cloud instance in the same way as for Linux VM.

**[HERE YOU CAN FIND SOME IMPORTANT ORGANISATIONAL NOTES](../ORG-NOTES.md)**
