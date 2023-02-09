# Task 2. Configure CLI tools for JavaScript/Node.js development and Bash scripting

### Note:
> - A VM should be set up and a Linux distribution is configured.
> - Personal GitHub repository (public or private) should be used for storing and sharing scripts, created during the execution of tasks.
> - If necessary, share access to your repo with a mentor, an expert, or another person who will evaluate your work or help to solve issues.

### Sub-task 1. Configure CLI tools for JavaScript/Node.js development and Bash scripting
1. In your Linux distribution **configure** [Vim](https://www.vim.org/) to work with either [JavaScript](https://freshman.tech/vim-javascript/) or [Node.js](https://theselfhostingblog.com/posts/configuring-vim-for-node-js-development/) or both.
   **Try** editing your JavaScript/Node.js projects or pull one of the repositories ([nestjs-rest-api](https://github.com/EPAM-JS-Competency-center/nestjs-rest-api), [shop-angular](https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront), [shop-vue-vuex](https://github.com/EPAM-JS-Competency-center/shop-vue-vuex-cloudfront), [shop-react-redux](https://github.com/EPAM-JS-Competency-center/shop-react-redux-cloudfront)) to play around.
2. **Set up** Vim for Bash scripting using one of the tutorials:
    - [Setting up Vim for Bash Scripting](https://dev.to/mr_destructive/setting-up-vim-for-bash-scripting-2ef5)
    - [How to Make ‘Vim Editor’ as Bash-IDE Using ‘bash-support’ Plugin in Linux](https://www.tecmint.com/use-vim-as-bash-ide-using-bash-support-in-linux/)
3. **[Optional]** If you prefer working with the [Nano editor](https://www.nano-editor.org/), **configure** it and **enable** some useful stuff as shown [here](https://linuxhint.com/configure_nano_text_editor_nanorc/).
   **Add** syntax highlighting from [this](https://github.com/scopatz/nanorc) repo (or on [AskUbuntu](https://askubuntu.com/questions/90013/how-do-i-enable-syntax-highlighting-in-nano)).
4. **[Optional]** **Install** and **configure** [ZSH](https://ohmyz.sh/#install). **Add** some [plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins) for your convenience.

### Sub-task 2. Create a Bash script using Vim

1.	**Create** an empty directory named **data** with a file named **_users.db_** in the project’s **module_4/task_2** directory.
2.	**Create** a directory named **scripts** in the project’s **module_4/task_2** directory.  Using Vim editor in your terminal **create** a [shell script](https://linuxconfig.org/bash-scripting-tutorial-for-beginners) named **_db.sh_** in the **scripts** directory. This script must support the following commands:
      - **Adds** a new line to the **_users.db_**. The script must **prompt** a user to type the **username** of a new entity. After entering the **username**, the user must be prompted to type a **role**. 
        ```shell
        $ db.sh add
        ```
        Validation rules:
          - **username** – Latin letters only
          - **role** – Latin letters only </br></br>

      - New entity of **_users.db_** should be a comma-separated value like: `_username_, _role_`.
      - The script must **check** the existence of the **_users.db_** file (for all commands accept `$ db.sh` or `$ db.sh help` ones) and **prompt** to confirm to create one if it does not exist and to continue initial operation after creation is completed.
        
        ```shell
        $ db.sh
        ```
        
         or
        
        ```shell
        $ db.sh help
        ```
      - **Prints** instructions on how to use this script with a description of all available commands (`add`, `backup`, `find`, `list`, `help`)

        ```shell
        $ db.sh backup
        ```
      - **Creates** a new file, named **_%date%-users.db.backup_** which is a copy of current **_users.db_**
        
        ```shell
        $ db.sh restore
        ```

      - **Takes** the last created backup file and **replaces** **_users.db_** with it. If there are no backups - script should print: **“No backup file found”**
        
        ```shell
        $ db.sh find 					
        ```

      - **Prompts** the user to type a **username**, then **prints** **username** and **role** if such exists in **_users.db_**. If there is no user with the selected username, the script must **print**: **“User not found”**. If there is more than one user with such a username, **print** all found entries.
        
        ```shell
        $ db.sh list
        ```

      - **Prints** the content of the **_users.db_** in the format:
        
        ```shell
        N. username, role 	
        ```

        where **N** – a line number of an actual record

      - **Accepts** an additional optional parameter **--inverse** which allows results in the opposite order – from bottom to top.
    Running the command `$ db.sh list --inverse` will return the result as follows:
        
        ```shell
        $ db.sh list --inverse
        
          10. John, admin
          9. Valerie, user
          8. Ghost, guest
           …
        ```

**NB: [here](./db) you can find some samples that you might find handy while solving the task.**

**[HERE YOU CAN FIND SOME IMPORTANT ORGANISATIONAL NOTES](../../../ORG-NOTES.md)**