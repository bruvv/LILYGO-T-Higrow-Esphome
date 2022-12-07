YAML_FILES = LILYGO-T-Higrow-ESP32-*.yaml

.PHONY: build lint requirements

build:
	esphome compile $(YAML_FILES)

lint:
	yamllint .

requirements:
	pip3 install wheel
	pip3 install -r requirements.txt
