#/usr/bin/env bash

de() {
  container=$1
  shift
  command=$@
  echo $container
  echo $command

  /usr/bin/docker exec -it $(docker ps | grep "$container\." | awk '{print $1}') sh -c "$command";
}

alias dsls="docker service ls"

dsl() {
  service_name=$1

  docker service logs $service_name
}

dslf() {
  service_name=$1

  docker service logs -f $service_name
}

dsp() {
  service_name=$1

  /usr/bin/docker service ps --no-trunc $service_name
}

_docker_services_completions()
{
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  COMPREPLY=($(compgen -W "$(/usr/bin/docker service ls | awk '{print $2}' | xargs | cut -d' ' -f2-)" "${COMP_WORDS[1]}"))
}

complete -F _docker_services_completions dsp
complete -F _docker_services_completions de
complete -F _docker_services_completions dsl
complete -F _docker_services_completions dslf
