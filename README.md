#  structurizr-c4plantuml-exporter

This project is about being able to add some functionality to the basic structurizr PlantUML C4 export.

## Quick start

1. Pull the docker image
```bash
docker pull matdurand/structurizr-c4plantuml-exporter:latest
```

2. Use the docker image
```bash
docker run -v "/myStructurizrModel:/workspace" matdurand/structurizr-c4plantuml-exporter:latest /workspace/workspace.dsl /workspace/generated
```

## Options

### Directions

Sometimes it's useful to provide a bit more control on the layout option. PlantULM C4 does provide some layout options
with Rel_D, Rel_U, Rel_L and Rel_R, but these options can't be generated by the regular exporter.

For example, in the DSL you could do this
```
container mySystem "Containers" {
    include *
    autoLayout
    properties {
        direction_container1_container2 right
    }
}
```
and it would make the relationship from container1 to container2 exit on the right of container1.

#### How it works

When the DSL is parsed, there is identity table being build with the name of the elements referenced in the DSL. When we reach the exporter, these names are gone, 
but we need them because there are going to be referenced in the `properties` of the diagram.

### Relationship labels

Sometimes it's useful in context diagrams to remove the relationship labels because they just clutter the diagram.

```
systemContext mySystem "systemcontext-mysystem" {
    title "Some title"
    include *
    autoLayout lr
    properties {
        c4plantuml.relationships.description false
    }
}
```
