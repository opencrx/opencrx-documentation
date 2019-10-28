# openCRX SDK for Ant Step-by-Step Guide #

This guide explains how to build _openCRX 4.2_ from the sources.

## Prerequisites ##

Make sure that you have the following software installed:

* [JDK 1.8](http://www.oracle.com/technetwork/java/javase/downloads/) or [OpenJDK 1.8](https://jdk8.java.net/)
* [Apache Ant 1.9.7](http://ant.apache.org/bindownload.cgi)
* [GIT](http://git-scm.com/downloads)

Prepare and build _openMDX 2.16_ as described in [openMDX 2.16 for Ant Step-by-Step](https://sourceforge.net/p/openmdx/wiki/Sdk216.StepByStepAnt/).

## Build for Linux ##

In a first step open a shell and cd to a directory where you have installed _openMDX SDK_. 

```
cd /tmp/dev
. ./setenv.sh
```

Get the openCRX sources from the GIT repository:

```
git clone https://git.code.sf.net/p/opencrx/opencrx4 opencrx4
```

Then prepare the _opt_ directory:

```
cd opencrx4
git checkout OPENCRX_4_2_0
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
git clone https://git.code.sf.net/p/opencrx/opencrx4 opencrx4
```

Then prepare the _opt_ directory:

```
cd opencrx4
git checkout OPENCRX_4_2_0
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
