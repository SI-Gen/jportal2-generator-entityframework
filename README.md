# JPortal2 Entity Framework Core 6 Template
This is a JPortal2 template for generating EntityFrameWork-based database access layers
For information regarding the generator that is used by this template, refer to the main
[JPortal2](https://github.com/SI-Gen/jportal2) repo

## Quickstart

### Pre-build Docker Container
JPortal 2 offers a pre-build docker container that can be used for automatic downloading and running of templates

```shell
ENTITY_FRAMEWORK_TEMPLATE_VERSION=1.0.9

docker run --rm \
-v <si_directory>:/local/sql/si \
-v <output_directory>:/local/generated_sources \
ghcr.io/si-gen/jportal2:latest \
--inputdir=/local/sql/si \
--template-generator "EntityFrameworkCore:/local/generated_sources" \
--download-template "EntityFrameworkCore:https://github.com/SI-Gen/jportal2-generator-entityframework/archive/refs/tags/$ENTITY_FRAMEWORK_TEMPLATE_VERSION.zip|stripBaseDir"
```

This command adds volume mounts for both the input (SI) directory and the output directory as well as removes itself after it is done generating

### Manual Exection using the Java JAR file
```shell

#Change directory to template directory
cd <template_directory>

#Download version $VERSION template
ENTITY_FRAMEWORK_TEMPLATE_VERSION=1.0.9

curl -fsSL https://github.com/SI-Gen/jportal2-generator-entityframework/archive/refs/tags/$ENTITY_FRAMEWORK_TEMPLATE_VERSION.zip > EntityFrameworkCore.zip && unzip EntityFrameworkCore.zip && rm EntityFrameworkCore.zip && mv jportal2-generator-entityframework-$ENTITY_FRAMEWORK_TEMPLATE_VERSION EntityFrameworkCore

#Run JPortal2
java -jar jportal.jar \
--inputdir=<input_directory> \
--template-location=<template_directory> \
--template-generator EntityFrameworkCore:<output_directory>
```