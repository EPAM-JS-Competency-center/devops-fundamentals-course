# Task 1: Dockerize a back-end app

## Task objectives:

As a lead engineer you are responsible for making the back-end app Cloud Native.
The first thing you should do in scope of upcoming improvements is to dockerize the app.

In scope of this work you need to:

1. **Dockerize** the [back-end app](https://github.com/EPAM-JS-Competency-center/nestjs-rest-api/tree/feat/devops-cicd-lab):
  - **add** _Dockerfile_ which will build an image with the back-end app
  - **add** _.dockerignore_ to prevent unnecessary files from getting into the final Docker image
  - **try** to make your final image as minimal as possible by applying some [Dockerfile optimisation techniques](https://www.codewall.co.uk/writing-an-optimized-dockerfile/)
2. **Publish** your image to any [free private or public Docker registry](https://www.slant.co/topics/2436/~best-docker-image-private-registries) based on your preference.
3. **Create** bash script (**_build_docker_image.sh_**), which will build a Docker image of the app, add some tags, and push to your registry.
4. **Pull** the image from registry and **execute**/**run** it locally, so that you can access the app through your browser or with curl.
5. OPTIONALLY*, **Set** up Docker on your VM. Then **create** a shell script, which will SSH to your VM, pull Docker image from registry and run it on port `81`
6. OPTIONALLY*, **Create** `docker-compose.yml` to run the app in development environment.

**[HERE YOU CAN FIND SOME IMPORTANT ORGANISATIONAL NOTES](../../../ORG-NOTES.md)**
