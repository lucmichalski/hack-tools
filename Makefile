# .SILENT :

# Base package
BASE_PACKAGE="github.com/LasCC"

# App name
APPNAME="Hack-Tools"

# Extract version infos
VERSION:=`git describe --tags`
GIT_COMMIT:=`git rev-list -1 HEAD --abbrev-commit`
BUILT:=`date`

# Include common Make tasks
root_dir:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
makefiles:=$(root_dir)/makefiles
include $(makefiles)/help.Makefile

all: image docker-dist changelog

## Clean built files
clean:
	echo ">>> Removing generated files ..."
	-rm -rf dist node_modules
.PHONY: clean

## Create Docker image
image:
	echo ">>> Building Docker image ..."
	docker build --rm -t lascc/hack-tools .
.PHONY: image

## Create distribution files with Docker
docker-dist:
	echo ">>> Building distribution files ..."
	mkdir -p $(PWD)/dist
	docker run --rm -ti -v $(PWD)/dist:/app/dist lascc/hack-tools
.PHONY: docker-dist

## Generate changelog
changelog:
	standard-changelog --first-release
.PHONY: changelog