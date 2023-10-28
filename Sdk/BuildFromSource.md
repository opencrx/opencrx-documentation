# Build from source #

This guide explains how to build _openCRX_ from the sources.

## Prerequisites ##

Make sure that you have the following software installed:

* [JDK 11](http://www.oracle.com/technetwork/java/javase/downloads/) or [OpenJDK 11](https://openjdk.java.net/projects/jdk/11/)
* [GIT](http://git-scm.com/downloads)

## Build ##

Get the openCRX sources from the GIT repository:

```
git clone https://github.com/opencrx/opencrx.git opencrx
```

And then build the _openCRX_.

```
cd opencrx
git checkout opencrx-v5.3.0
./gradlew clean
./gradlew assemble
```

**Note:** If the build fails with a certificate validation exception see [here](https://github.com/opencrx/opencrx-documentation/issues/1) how to solve the issue. 

## Eclipse project files ##

Generate the Eclipse project files as follows:

```
./gradlew eclipse
```

This generates the Eclipse project files _opencrx/core/.project_ and _opencrx/core/.classpath_. Import the project into a new or existing Eclipse workspace.  

## Congratulations ##
Congratulations! You have successfully built _openCRX SDK_ from the sources.
