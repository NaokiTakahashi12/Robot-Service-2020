
DOCKERFILE := Dockerfile
PROJECT := robosrv
ORIGIN := $(shell git remote get-url origin | sed -e 's/^.*@//g')
REVISION := $(shell git rev-parse --short HEAD)
DOCKERFILES := $(sort $(wildcard */$(DOCKERFILE)))
USERNAME := naokitakahashi12

RS_MELODIC_DIR := melodic
RS_MELODIC_TAG := ros-melodic

define dockerbuild
	@docker build \
		--file $1 \
		--build-arg GIT_REVISION=$(REVISION) \
		--build-arg GIT_ORIGIN=$(ORIGIN) \
		--tag $2 \
	$3
endef

.PHONY: all
all: help

.PHONY: build
build: \
	$(RS_MELODIC_TAG) \

$(RS_MELODIC_TAG): $(RS_MELODIC_DIR)/$(DOCKERFILE)
	$(eval BUILD_DIR := "$(RS_MELODIC_DIR)")
	$(eval DOCKERIMAGE := "$(USERNAME)/$(PROJECT):$@")
	$(call dockerbuild, $<, $(DOCKERIMAGE), $(BUILD_DIR))

.PHONY: clean
clean:
	@docker image rm $(USERNAME)/$(PROJECT):$(BINARY_BIONIC_CITADEL_TAG)

.PHONY: pull
pull:
	@docker pull $(USERNAME)/$(PROJECT):$(BINARY_BIONIC_CITADEL_TAG)

.PHONY: help
help:
	@echo ""
	@echo " make <command> [option]"
	@echo ""
	@echo " Support commands"
	@echo " help  : print support commands"
	@echo " build : building docker images"
	@echo " clean : clean docker images"
	@echo " pull  : pulling docker images from registry"
	@echo ""
	@echo " Options"
	@echo " See the 'make --help'"
	@echo ""

