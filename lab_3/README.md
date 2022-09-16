### Lab 3: Infrastructure as Code. CI/CD fundamentals.

##### TODOs:
- add links

# Sub-task 1 - Configure Continuous Integrations (CI) for local development: front-end and back-end

0. **Clone**/**pull** given [front-end](https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront/tree/feat/devops-cicd-lab) and [back-end](https://github.com/EPAM-JS-Competency-center/nestjs-rest-api/tree/feat/devops-cicd-lab) apps.
1. **Configure** the following integrations for both apps and **add** appropriate npm scripts for convenience:
   - [commit linting](https://commitlint.js.org/#/?id=getting-started) 
   - linting for *.js/*.ts files with [eslint](https://eslint.org/) and [typescript-eslint](https://typescript-eslint.io/docs/)
   - running unit tests (in *.test|spec.ts|js files) with [jest](https://jestjs.io/). Optionally*, add a test coverage threshold (~5-20%)
   - dependencies check with [npm audit](https://docs.npmjs.com/cli/v6/commands/npm-audit) or [Snyk Open Source](https://snyk.io/product/open-source-security-management/)
   - static code analysis with [CodeCov](https://about.codecov.io/for/open-source/) or [SonarQube Community Edition](https://www.sonarqube.org/downloads/) and [SonarScanner](https://www.npmjs.com/package/sonarqube-scanner) (**NB: to use SonarQube you must run it locally in a Docker container**)
   - release using [standard version](https://www.npmjs.com/package/standard-version)
   - optionally*, configure e2e testing with [Cypress](https://www.cypress.io/) or [Webdriver.io](https://webdriver.io/)
2. **Configure** the following git hooks using [husky](https://www.npmjs.com/package/husky) npm package:
   - _pre-commit_ - commit message linting
   - _commit_ - js|ts linting
   - _push_ - running unit tests, static code analysis and dependencies audit
Optionally*, **configure** [lint-staged](https://www.npmjs.com/package/lint-staged)
3. **Add** and/or **update** your shell scripts from previous labs to quickly invoke all quality tools and checks.
4. **Create** a single sh script, with will execute other scripts - quality checks and app build process.

### Sub-task 2 - Configure CI/CD pipeline for front-end app

1. **Build** CI/CD pipeline using any of CI/CD or cloud providers.
Pipeline should have the following stages:
   - _source code check-out_
   - _code quality checks_: linting, testing, dependencies audit, app's build, and optionally static code analysis
   - _build_: build the app with production configuration
   - _deployment_: publishes your static web app to any content delivery network (CDN)
> **NB**:
  >- if you have an account in AWS, Azure, GCP (or can create one) you can use their storage and CDN services.
  >- if for some reason you can't use any of mentioned cloud providers, you can use any free [CDN](https://geekflare.com/free-cdn-list/) or use web server to server your static assets on your workstation.

### Sub-task 3 - Configure CI/CD pipeline for back-end app

1. **Dockerize** the back-end app:
   - **add** _Dockerfile_ which will build an image with the back-end app
   - **add** _.dockerignore_ to prevent unnecessary files from getting into the final Docker image
   - **try** to make your final image as minimal as possible by applying some [Dockerfile optimisation techniques](https://www.codewall.co.uk/writing-an-optimized-dockerfile/)
2. Publish your image to any free Docker registry based on your preference.
> **NB**:
  >- if you have an account in AWS, Azure, GCP (or can create one) you can use their container registries.
  >- if for some reason you can't use any of mentioned cloud providers, you can use any free [container registry](https://www.slant.co/topics/2436/~best-docker-image-private-registries)
3. **Create** sh script, which will build Docker image/container of the app and push to your registry.
4. **Pull** the image from registry and **execute**/**run** it locally, so that you can access the app through your browser or with curl.
5. OPTIONALLY*, **Build** CI/CD pipeline using any free CI/CD provider or CI/CD tools in one of most-popular cloud providers (AWS, Azure, GCP)
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
