#!/bin/bash
# Convert GitHub Actions YAML to PlantUML diagram
# Usage: yaml2plantuml.sh <workflow.yml>
# don't forget to pip install yq

yaml2plantuml() {
  echo "@startyaml"
  echo "<style>"
  echo "yamlDiagram {"
  echo "  BackgroundColor #fff/aaf"
  echo "}"
  echo "</style>"
  yq -y 'del(.jobs.render.steps[].run)' "$1" | sed "s/^'\([^']*\)':/\1:/g"
  echo "@endyaml"
}

yaml2plantuml "$@"
