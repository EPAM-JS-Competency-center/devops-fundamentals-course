### Lab 3: Infrastructure as Code. CI/CD fundamentals.

##### TODOs:
- add links

# Sub-task 1 - Configure Continuous Integrations (CI) for local development: front-end and back-end

NPM Scripts:
commit lint
es linting
testing
[static code analysis (optionally deploy and configure SonarScanner (community edition)) or use CodeCov]
npm audit
release

hooks:
- pre-commit (commit message linting)
- commit - es linting
- push - unit tests, static code analysis + npm audit
- optionally configure git staged

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
    - quality tools & add script to run quality tools
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
