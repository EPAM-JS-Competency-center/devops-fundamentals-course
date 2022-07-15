
### Lab 1: Operating systems. Linux's basics. Command line tools.

**Pre-requisites**:

1.	A VM is set up and a Linux distribution is configured.
2.	A new GitHub repository (public or private) is created. There you will keep your solutions to the program’s labs.
3.	If necessary, share access to your repo with a mentor, an expert, or another person who will evaluate your work or help to solve issues.

#### Part 1. Configure CLI tools for JavaScript/Node.js development and Bash scripting

1. In your Linux distribution **configure** [Vim](https://www.vim.org/) to work with either [JavaScript](https://freshman.tech/vim-javascript/) or [Node.js](https://theselfhostingblog.com/posts/configuring-vim-for-node-js-development/) or both.
**Try** editing your JavaScript/Node.js projects or pull one of the repositories ([nestjs-rest-api](https://github.com/EPAM-JS-Competency-center/nestjs-rest-api), [shop-angular](https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront), [shop-vue-vuex](https://github.com/EPAM-JS-Competency-center/shop-vue-vuex-cloudfront), [shop-react-redux](https://github.com/EPAM-JS-Competency-center/shop-react-redux-cloudfront)) to play around.
2. **Set up** Vim for Bash scripting using one of the tutorials:
   - [Setting up Vim for Bash Scripting](https://dev.to/mr_destructive/setting-up-vim-for-bash-scripting-2ef5)
   - [How to Make ‘Vim Editor’ as Bash-IDE Using ‘bash-support’ Plugin in Linux](https://www.tecmint.com/use-vim-as-bash-ide-using-bash-support-in-linux/)
3. **[Optional]** If you prefer working with the [Nano editor](https://www.nano-editor.org/), **configure** it and **enable** some useful stuff as shown [here](https://linuxhint.com/configure_nano_text_editor_nanorc/).
**Add** syntax highlighting from [this](https://github.com/scopatz/nanorc) repo (or on [AskUbuntu](https://askubuntu.com/questions/90013/how-do-i-enable-syntax-highlighting-in-nano)).
4. **[Optional]** **Install** and **configure** [ZSH](https://ohmyz.sh/#install). **Add** some [plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins) for your convenience.

#### Part 2. Create a Bash script using Vim

1.	**Create** an empty directory named **data** with a file named **_users.db_** in the project’s **lab_1** directory.
2.	**Create** a directory named **scripts**.  Using Vim editor in your terminal **create** a [shell script](https://linuxconfig.org/bash-scripting-tutorial-for-beginners) named **_db.sh_** in the **scripts** directory.
This script must support the following commands:

```shell
$ db.sh add
```

**Adds** a new line to the **_users.db_**. The script must **prompt** a user to type the **username** of a new entity. After entering the **username**, the user must be prompted to type a **role**.

Validation rules:

**username** – Latin letters only

**role** – Latin letters only

New entity of **_users.db_** should be a comma-separated value like: _username_, _role_
The script must **check** the existence of the **_users.db_** file (for all commands accept `$ db.sh` or `$ db.sh help` ones) and **prompt** to confirm to create one if it does not exist and to continue initial operation after creation is completed.

```shell
$ db.sh
```

Or

```shell
$ db.sh help
```

**Prints** instructions on how to use this script with a description of all available commands (`add`, `backup`, `find`, `list`, `help`)

```shell
$ db.sh backup
```

**Creates** a new file, named **_%date%-users.db.backup_** which is a copy of current **_users.db_**

```shell
$ db.sh restore
```

**Takes** the last created backup file and **replaces** **_users.db_** with it.
If there are no backups - script should print: **“No backup file found”** 						

```shell
$ db.sh find 					
```

**Prompts** the user to type a **username**, then **prints** **username** and **role** if such exists in **_users.db_**.

If there is no user with the selected username, the script must **print**: **“User not found”**.

If there is more than one user with such a username, **print** all found entries.

```shell
$ db.sh list
```

**Prints** the content of the **_users.db_** in the format: 

```shell
N. username, role 	
```

where **N** – a line number of an actual record

**Accepts** an additional optional parameter **--inverse** which allows results in the opposite order – from bottom to top.
Running the command `$ db.sh list --inverse` will return the result as follows:

```shell
$ db.sh list --inverse

  10. John, admin
  9. Valerie, user
  8. Ghost, guest
   …
```

#### Part 3. Automate the build process with Bash

1. Using Vim or Nano editor **create** a shell script **_build-client.sh_** in the **scripts** folder. This script must perform the following operations over the source of [this GitHub repository](https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront) (you will need to clone it):
   1. **Install** the app’s npm dependencies.
   2. **Invoke** the client app’s **build** command with the **--configuration** flag. 
   3. **Set** and use the **ENV_CONFIGURATION** (**production** or **empty string** for development configuration) env variable to specify the [app’s configuration](https://angular.io/guide/build#configure-target-specific-file-replacements) to use during the build. 
   4. When the build is finished script should **compress** all built content/files in one **_client-app.zip_** file in the **dist** folder.
   5. **Check** if the file **_client-app.zip_** exists before building. If so, remove it from the file system and proceed with the build.
2. Using Vim or Nano editor **create** a new shell script (**_quality-check.sh_**) which will run code quality tools (**linting**, **unit tests**, **npm audit**, etc.) over the client app from the previous step and report if the app has some problems with its quality.
3. **[Optionally]**, **automate** the build and quality processes for [this](https://github.com/EPAM-JS-Competency-center/nestjs-rest-api) app/repo.

#### Part 4. Automate tasks with JSON files

1. Using Vim or Nano editor **create** a shell script (**_update-pipeline-definition.sh_**) that will modify with the [JQ lib](https://stedolan.github.io/jq/) ([here](https://www.educba.com/linux-jq/) you can find some examples) [this](./pipeline.json) JSON file and create a new one (e.g. **_pipeline-{date-of-creation}.json_**) with the following changes:
   1. The **metadata** property is **removed**. 
   2. The **value** of the pipeline’s version property is **incremented** by **1**. 
   3. The **Branch** property in the **Source** action’s configuration is **set** to a value from the script’s parameter/flag **--branch**.
   The default value is **main**. (Assume that it is a branch name of a feature you’re going to point your pipeline). 
   4. The **Owner** property in the **Source** action’s configuration is **set** to a value from the script’s parameter/flag **--owner**.
   (Assume that it is a GitHub owner/account name of a repository you’re going to use within the pipeline).
   5. **[Optionally]**, the Repo property in the Source action’s configuration is **set** to a value from the script’s parameter/flag **--repo**.
   (Assume that it is a GitHub repository you’re going to use within the pipeline). 
   6. The **PollForSourceChanges** property in the **Source** action’s configuration is **set** to a value from the script’s parameter/flag **--poll-for-source-changes**.
   (Assume that it is a property that activates and deactivates the automatic pipeline execution when source code is changed). The default value is **false**. 
   7. The **EnvironmentVariables** properties in each action are **filled** with a stringified JSON object containing the **BUILD_CONFIGURATION** **value** from the **--configuration** parameter flag.
2. The path to the **_pipeline.json _** or another JSON definition file should be **passed** as the first argument to the script.
The following execution should produce a pipeline definition like [this](./pipeline-upd.json) one.

```shell
 $ ./update-pipeline-definition.sh ./pipeline.json --configuration production --owner boale --branch feat/cicd-lab --poll-for-source-changes true
```

3. The script should **validate** if JQ is installed on the host OS.
If not, **display** commands on how to install it on different platforms and **stop** script execution.
4. The script should **validate** if the necessary properties are present in the given JSON definition.
If not, it should **throw** an error and **stop** execution.
5. The script should **validate** if the path to the pipeline definition JSON file is provided.
If not, it should **throw** an error and **stop** execution.
6. It should **perform** only **1.1** and **1.2** actions if no additional parameters are provided.
E.g.: `$ ./update-pipeline-definition.sh ./pipeline.json`.
7. **[Optionally]** **implement** a **--help** parameter which will **display** instructions on how to use the script.
8. **[Optionally]**, **update** the script to ask a user to **prompt** each argument in a wizard-style (feel free to style it as you wish):
      
```
  $ ./update-pipeline-definition.sh
    > Please, enter the pipeline’s definitions file path (default: pipeline.json): 
    > Which BUILD_CONFIGURATION name are you going to use (default: “”):
    > Enter a GitHub owner/account: boale
    > Enter a GitHub repository name: shop-angular-cloudfront
    > Enter a GitHub branch name (default: develop): feat/cicd-lab
    > Do you want the pipeline to poll for changes (yes/no) (default: no)?: yes
    > Do you want to save changes (yes/no) (default: yes)?: yes
```

#### [OPTIONAL] Part 5. Strengthen your shell scripting skills on [real-world tasks](https://www.linode.com/docs/guides/solving-real-world-problems-with-bash-scripts-a-tutorial/)

1. **Create** a shell script that will watch free disk space. The bash script should follow watch the free space of your hard disks and warns you when that free space drops below a given threshold.
The value of the threshold is given by the user as a command line argument. Notice that if the program gets no command line argument, a default value is used as the threshold.
2. **Create** a shell script, which will count the number of files that exist in each given directory and its subdirectories.
Integrate it into the build-client.sh script to calculate the count of files in the client’s app dist folder after the build and display accordingly.
3. **Complete** [this](./self-check.md) self-check questions.

#### [OPTIONAL] Part 6. Autocompletion, aliases. Automation for commands.
_Read [Bash Autocompletion](https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html)_
_Read [Creating a bash completion script](https://iridakos.com/programming/2018/03/01/bash-programmable-completion-tutorial)_
In examples folder you can find configuration how to alias/autocomplete work with docker.

1. **Create** autocompletion script that will help you to show available arguments for all scripts.
2. **Read** [information](https://linuxhint.com/bash_command_history_usage/) how to manage history of all commands you running
   1. for example, when you use bash shell you could press "Ctrl + R" and start typing your command, it will search through all the history. Pressing "Ctrl + R" will cycle over history for matches.
   2. practice with commands and how to configure bash history and use it efficiently.

**NB: [here](./samples) you can find some samples that you might find handy while solving the lab tasks.**

**[HERE YOU CAN FIND SOME IMPORTANT ORGANISATIONAL NOTES](../ORG-NOTES.md)**
