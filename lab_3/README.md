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
   - static code analysis with [CodeCov](https://about.codecov.io/for/open-source/) or [SonarQube Community Edition](https://www.sonarqube.org/downloads/) and [SonarScanner](https://www.npmjs.com/package/sonarqube-scanner) 
   - release using [standard version](https://www.npmjs.com/package/standard-version)
   - optionally*, configure e2e testing with [Cypress](https://www.cypress.io/) or [Webdriver.io](https://webdriver.io/)
2. **Configure** the following git hooks using [husky](https://www.npmjs.com/package/husky) npm package:
   - _pre-commit_ - commit message linting
   - _commit_ - js|ts linting
   - _push_ - running unit tests, static code analysis and dependencies audit
Optionally*, **configure** [lint-staged](https://www.npmjs.com/package/lint-staged)
3. **Add** and/or **update** your shell scripts from previous labs to quickly invoke all quality tools and checks.
4. **Create** a single sh script, with will execute other scripts for quality checks and app build process.

### Part 1: CI/CD for back-end
 - Local set up
   - quality tools
   - build and prepare docker image
       - create Dockerfile + create script for building docker image for back-end
       - execute docker image locally
- Cloud setup / Cloud CI/CD
  -  add script which will execute prev script and push docker image to docker registry based on preferences:
    - if you're going to deploy the app to a cloud provider
        - AWS: Elastic Container Registry
        - Azure: Azure Container Registry
        - GCP: Google Container Registry
        - other: DockerHub or other free registry
  - add script to run quality tools
  - Build CI/CD in any of CI/CD or cloud providers:
    - source code check-out
    - code quality checks
    - build and publish docker image
    - [optional] deployment (propose references on tutorials/guides/videos)

# configure SonarScanner (practise Docker)

### Part 2: CI/CD for front-end

- Local set up
    - quality tools
    - build app (use script from the first module)

- Cloud setup / Cloud CI/CD
    - CI/CD tools
      - AWS: CodePipeline + CodeBuild + CodeDeploy
      - AZUre - AzureDevOps
      - GCP:
      - Other
    - if you're going to deploy the app to a cloud provider
        - AWS: S3 + cloudfront
        - Azure: tools for static website hosting
        - GCP:tools for static website hosting
        - other:tools for static website hosting
    - Build CI/CD in any of CI/CD or cloud providers:
        - source code check-out
        - code quality checks
        - build and publish docker image
        - [optional] deployment (propose references on tutorials/guides/videos)
