# Task 1: Get started with GitLab CI

## Task objectives:

In scope of Cloud migration activities you were tasked to investigate CI/CD tools and create demonstration pipelines for apps you're currently developing.
If your team and delivery manager are okay with chosen tools, these tools will be applied for other projects as well.
After some investigation and consideration you decided to use GitLab CI.
You are already using it as version control system (VCS) and recently project's DevOps engineer has configured continuous integration server for some automation tasks.

In scope of this task you need to: 

1. **Create** two repos in [gitbud.epam.com:](https://gitbud.epam.com/) one for [client app](https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront/tree/feat/devops-cicd-lab) (or any static Web app upon your preference) and one for [back-end app](https://github.com/EPAM-JS-Competency-center/nestjs-rest-api/tree/feat/devops-cicd-lab) (or any static Web app upon your preference).
3. **[Create](https://docs.gitlab.com/ee/ci/quick_start/#create-a-gitlab-ciyml-file)** `.gitlab-ci.yml` file in each project. 
4. **Configure** placeholders for actions as follows:
   - static web app/front-end:
     - running unit tests
     - running eslint check
     - running npm packages audit
     - building the app (for typescript/babel projects)
     - deploying the app
   - api back-end:
     - running unit tests
     - running eslint check
     - running npm packages audit
     - building the docker image of your app and pushing it to a registry
Every action for now should just log a text message with action name.
Deployment stages/jobs should run only for main or develop branches. (So you need to push changes on a separate branch and create PR to check if it works as expected)
5. **Push** changes to repos/branches and check if pipelines work.
6. **Investigate** CI/CD configuration options and how you can deploy apps to e.g. AWS Cloud.
7. **Find out** the ways how you can improve the pipelines (e.g. running jobs in parallel, or adding manual approval before deployment).

**[HERE YOU CAN FIND SOME IMPORTANT ORGANISATIONAL NOTES](../../../ORG-NOTES.md)**
