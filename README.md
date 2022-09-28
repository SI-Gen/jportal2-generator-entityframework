# jportal2-generator-entityframework
This is a JPortal2 generator that generates EntityFrameWork-based database access for the Vanguard framework

Usage:
======

```shell

#Change directory to template directory
cd <template_directory>

#Download version $VERSION template
ENTITY_FRAMEWORK_TEMPLATE_VERSION=1.2
curl -fsSL https://github.com/SI-Gen/jportal2-generatoror-entityframework/releases/tag/$ENTITY_FRAMEWORK_TEMPLATE_VERSION/jportal2-generator-vanguardg-sqlalchemy-$ENTITY_FRAMEWORK_TEMPLATE_VERSION.zip > sqlalchemy.zip && unzip sqlalchemy.zip && rm sqlalchemy.zip

#Run JPortal2
java -jar jportal.jar \
        --inputdir=<input_directory> \
        --template-location=<template_directory> \
        --template-generator \
          EFDBContextV2:<output_directory>
        --template-generator \
          EFDBContextImplV2:<output_directory>

```
Output:
=======