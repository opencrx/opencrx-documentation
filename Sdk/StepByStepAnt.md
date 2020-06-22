# openCRX SDK for Ant Step-by-Step Guide #

This guide explains how to build _openCRX 3.0_ from the sources.

## Prerequisites ##

Make sure that you have the following software installed:

* [JDK 1.7](http://www.oracle.com/technetwork/java/javase/downloads/) or [OpenJDK 1.7](https://jdk7.java.net/)
* [Apache Ant 1.9.4](http://ant.apache.org/bindownload.cgi)
* [GIT](http://git-scm.com/downloads)

Prepare and build _openMDX 2.14_ as described in [openMDX 2.14 for Ant Step-by-Step](https://sourceforge.net/p/openmdx/wiki/Sdk214.StepByStepAnt/).

## Build for Linux ##

In a first step open a shell and cd to a directory where you have installed _openMDX SDK_. 

```
cd /tmp/dev
. ./setenv.sh
```

Get the openCRX sources from the GIT repository:

```
git clone ssh://<user>@git.code.sf.net/p/opencrx/opencrx2-git opencrx3
```

Then prepare the _opt_ directory:

```
cd opencrx3
git checkout OPENCRX_3_0_0
cd opt
ant install-opt
cd ..
```

And then build the _openCRX_.

```
ant all
```

## Build for Windows ##

In a first step open a shell and cd to a directory where you have installed _openMDX_.

```
cd \temp\dev
setenv.bat
```

Get the openCRX sources from the GIT repository:

```
git clone ssh://<user>@git.code.sf.net/p/opencrx/opencrx2-git opencrx3
```

Then prepare the _opt_ directory:

```
cd opencrx3
git checkout OPENCRX_3_0_0
cd opt
ant install-opt
cd ..
```

And then build the _openCRX_.

```
ant all
```

## Congratulations ##
Congratulations! You have successfully built _openCRX SDK_ from the sources.
