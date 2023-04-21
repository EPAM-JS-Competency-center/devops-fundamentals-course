# Task 1: Investigate IaC tools

## Task objectives:

You, as a key developer, received a task to investigate infrastructure as code (IaC) tools for a new project within account.
It's going to be a complex project with a microservice backed by a database and caching layer. It also will have a static website which will provide a rich user interface for customers all around the world.
AWS cloud is used to host all projects resources. 
After investigation, you should propose IaC tools that you will use to manage all project's infrastructure as well as automate delivery processes.

In scope of this task you need to:

1. **Investigate** how you will manage local environment with [Docker Compose](https://docs.docker.com/compose/).
**Check** the content of [docker-compose.yml](docker-compose.yml) and consider of how you can apply it to meet the requirements.
**Study** the [yaml file reference](https://yaml.org/spec/1.2.2/) to strengthen/discover YAML features if needed.
2. **Investigate** build and automation tools ([CodeBuild](https://docs.aws.amazon.com/codebuild/index.html), [GitLab CI](https://docs.gitlab.com/ee/ci/)).
**Check** [build-docker-image.buildspec.yml](build-docker-image.buildspec.yml), [buildspec.yml](buildspec.yml), [.gitlab-ci.yml](.gitlab-ci.yml) and think about how you can apply it to automate quality checks in upcoming project as well as applications' build and deployment processes. 
**Investigate** the [buildspec](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html) and the [.gitlab-ci.yml](https://docs.gitlab.com/ee/ci/yaml/gitlab_ci_yaml.html) files references and compare their capabilities and ease of use.
**Define** pros and cons list for each tool. Are there any alternatives or complimentary tools that can be used instead/with these tools?
3. **Investigate** infrastructure management (IaC) tools: [CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html), [AWS CDK](https://docs.aws.amazon.com/cdk/v2/guide/getting_started.html), and [Terraform](https://developer.hashicorp.com/terraform/tutorials?product_intent=terraform).
**Check** and compare the [cloud-formation.yaml](cloud-formation.yaml) template, [AWS CDK](cdk-app-sample) and [terraform](terraform-app-sample/examples/complete) sample projects.
What are the benefits you will get and challenges you can face if you use these tools? Are there any alternatives to these tools? Which one you'd prefer for the project?
4. **Create** a comparison table (or define in your mind) for each group of tools and define the following characteristics: `language and tools`, `easy of use`, `clear to understand`, `costs`, `community and support`, `maturity of the tool`, `issues that can appear`, etc.
5. **Define** which tools you'd propose for the project.

**[HERE YOU CAN FIND SOME IMPORTANT ORGANISATIONAL NOTES](../../../ORG-NOTES.md)**
