### Lab 3: Infrastructure as Code. CI/CD fundamentals.

#### Sub-task 1 - Configure Continuous Integrations (CI) for local development: front-end and back-end

0. **Clone**/**pull** given [front-end](https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront/tree/feat/devops-cicd-lab) and [back-end](https://github.com/EPAM-JS-Competency-center/nestjs-rest-api/tree/feat/devops-cicd-lab) apps.
1. **Configure** the following integrations for both apps and **add** appropriate npm scripts for convenience:
   - [commit linting](https://commitlint.js.org/#/?id=getting-started) 
   - linting for *.js/*.ts files with [eslint](https://eslint.org/) and [typescript-eslint](https://typescript-eslint.io/docs/)
   - running unit tests (in *.test|spec.ts|js files) with [jest](https://jestjs.io/). Optionally*, add a test coverage threshold (~5-20%)
   - dependencies check with [npm audit](https://docs.npmjs.com/cli/v6/commands/npm-audit) or [Snyk Open Source](https://snyk.io/product/open-source-security-management/)
   - static code analysis with [CodeCov](https://about.codecov.io/for/open-source/) or [SonarQube Community Edition](https://www.sonarqube.org/downloads/) and [SonarScanner](https://www.npmjs.com/package/sonarqube-scanner) (**NB: to use SonarQube you must run it locally in a Docker container**)
   - release using [standard version](https://www.npmjs.com/package/standard-version) or [release-please](https://github.com/googleapis/release-please) (**NB: in this case npm script is not needed**)
   - OPTIONALLY*, configure e2e testing with [Cypress](https://www.cypress.io/) or [Webdriver.io](https://webdriver.io/)
2. **Configure** the following git hooks using [husky](https://www.npmjs.com/package/husky) npm package:
   - _commit-msg_ - [commit message linting](https://git-scm.com/docs/githooks#_commit_msg)
   - _pre-commit_ - js|ts linting [before committing changes](https://git-scm.com/docs/githooks#_pre_commit)
   - _pre-push_ - running unit tests, static code analysis and dependencies audit [before the code is being pushed](https://git-scm.com/docs/githooks#_commit_msg)
   - OPTIONALLY*, **configure** [lint-staged](https://www.npmjs.com/package/lint-staged)
3.  **Update** your shell script from the lab #1 (**_quality-check.sh_**) to invoke the following quality tools and checks: _eslint_, _testing_, _dependencies check_, _static code analysis_.

#### Sub-task 2 - Configure CI/CD pipeline for front-end app

_Local setup_:

1. **Set** up a web server (Apache, Nginx, etc) on your VM.
2. **Create** a shell scrip (**_local_ci_cd.sh_**) which will:
    - run code quality tools
    - build your app (use **_build-client.sh_** from the lab #1)
    - using SSH and SCP tools copy and extracts app's files into web server's website hosting folder
2. **Add** npm script (**cicd:local**) which will execute the script from previous step.

_GitLab CI setup_:
Based on your solutions from previous tasks, **update** `.gitlab-ci.yml` for static web app and **implement** running tools (`testing`, `linting`, `audit`, `building` the app).
**Use** previously created scripts and configurations withing GitLab CI.
**Push** changes and check if jobs are executed properly.
Optionally, you can **configure** app deployment to the Cloud (AWS, Azure, etc) or any free CDN.

_Cloud setup_:

1. OPTIONALLY* **Build** CI/CD pipeline using any of CI/CD or cloud providers (not GitLab CI) and their tools.
Pipeline should have the following stages:
   - _source code check out_
   - _code quality checks_: linting, testing, dependencies audit, app's build, and optionally static code analysis
   - _build_: build the app with production configuration
   - _deployment_: publishes your static web app to any content delivery network (CDN)
> **NB**:
  >- if you have an account in AWS, Azure, GCP (or can create one) you can use their storage and CDN services, as well as their developer tools.
  >- You will need to create and use some additional configuration or infrastructure as a code (IaaC) configuration files to deploy your app
  >- if for some reason you can't use any of mentioned cloud providers, you can use any free [CDN](https://geekflare.com/free-cdn-list/) or use web server to server your static assets on your workstation.

### Sub-task 3 - Configure CI/CD pipeline for back-end app

_GitLab CI setup_:

Based on your solutions from previous tasks, **update** `.gitlab-ci.yml` for api back-end and **implement** running tools (`testing`, `linting`, `audit`, `building` the app).
**Use** previously created scripts and configurations withing GitLab CI.
**Push** changes and check if jobs are executed properly.
OPTIONALLY*, you can **configure** pushing docker image to any free container registry and deploying/running it on any free virtual machine in the Cloud.

_Cloud setup_:

OPTIONALLY*, **Build** CI/CD pipeline using any free CI/CD provider or CI/CD tools in one of most-popular cloud providers (AWS, Azure, GCP)
Pipeline should have the following stages:
   - _source code check-out_
   - _code quality checks_: linting, testing, dependencies audit, app's build, and optionally static code analysis
   - _build_: build Docker image/container with the app and publish/push to the container registry
   - _deployment_: which should use your container from the registry and execute it

> **NB**:
 >- you can your own set of pipeline stages. E.g. create separate steps for linting, testing, static code analysis and dependencies check
 >- you can use any cloud provider and/or CI/CD tools and platforms
 >- create necessary bash scripts and IaaC configurations for use in your CI/CD pipeline
 >- you can skip any of pipeline's stages of you feel stuck or overwhelmed
 >- use environmental variables to store credentials and/or configuration parameters
 >- if you can't build CI/CD pipeline using services or cloud providers, try to emulate it locally. 
    After all, CI/CD is all about automation of our routine work. And CI/CD services just execute your automated jobs.
    You have everything to emulate CI/CD workflows on your local machine.
