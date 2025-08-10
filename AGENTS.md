Guide for Contributors and AI Agents
This repository contains an ESPHome configuration and related build/CI infrastructure for the LILYGO T‑Higrow Wi‑Fi plant sensor. The configuration is packaged as a modular YAML project and is built and published automatically using GitHub Actions. This document serves as a guide for both human contributors and AI agents (like Codex) to understand the project layout, build process and conventions. Follow these guidelines when adding features, troubleshooting build errors or submitting pull requests.
1. Project structure
LILYGO-T-Higrow-ESP32.yaml – the main ESPHome configuration file. It defines device‐wide substitutions (device name, description, sensor calibration parameters), the ESP32 board (lolin_d32), and imports additional functionality from the common/ folder.
common/ – a collection of modular YAML files that can be included in the main configuration via the packages key. These files implement optional sensors and behaviours such as battery monitoring (battery.yaml), the DHT22 temperature/humidity sensor (dht.yaml), soil moisture and conductivity sensors (plantsensors.yaml), Bluetooth proxy support (bluetooth.yaml), a water‑pump controller (waterpump.yaml), a BME280 environmental sensor (bme280.yaml), deep‑sleep support (deepsleep.yaml) and diagnostic text sensors (text_sensors.yaml). To enable an option, uncomment it in the packages: section of LILYGO-T-Higrow-ESP32.yaml.
.github/workflows/ – GitHub Action workflows that lint and build the firmware and publish releases and web pages. The ci.yml workflow builds the configuration nightly and on pull requests using the esphome/build-action action; it compiles each YAML file against multiple ESPHome versions (stable and beta). The pr_test.yml workflow runs YAML linting using the configuration in .github/yamllint.yml and performs a build to verify that changes do not break compilation. The publish‑firmware.yml and publish‑pages.yml workflows are triggered on release tags and maintain the GitHub Pages site under the static/ folder.
static/ – source for the project’s GitHub Pages web site (https://bruvv.github.io/LILYGO-T-Higrow-Esphome). During publishing, the Jekyll build action takes the contents of static/ and outputs an output folder, while the latest firmware files are downloaded and placed in output/firmware.
2. Building the firmware locally
The configuration in this repository is designed to be built by GitHub Actions, but you can compile it locally to troubleshoot problems. ESPHome provides both a Python CLI and a Docker image.
Using the ESPHome CLI
Install ESPHome – if your environment has network access you can install the CLI with pip: pip install esphome. Alternatively use Docker as described below.
Compile the firmware – from the repository root, run:
esphome compile LILYGO-T-Higrow-ESP32.yaml
ESPHome will validate the YAML and generate a PlatformIO project. The CLI will report validation errors and any missing components. According to the ESPHome documentation, the CLI accepts release channel tags such as stable, beta and dev; stable points to the latest stable release and beta points to the most recent beta or falls back to the latest stable when no beta is available[1]. If you encounter build failures in GitHub Actions due to a new release, you can pin the ESPHome version locally with the --version flag, e.g. esphome --version 2025.4.0 compile ….
Flash the firmware – once the firmware compiles, you can flash it to a device connected via USB with esphome run LILYGO-T-Higrow-ESP32.yaml. The CLI validates the configuration, then compiles and uploads the binary to your ESP32 board[2]. After the initial flash, future updates can be installed over Wi‑Fi.
Using Docker
ESPHome also provides an official Docker image. Pull the image and run it with your configuration mounted into /config:
docker pull ghcr.io/esphome/esphome docker run --rm -v "$PWD":/config -it ghcr.io/esphome/esphome run LILYGO-T-Higrow-ESP32.yaml
The Docker tags follow the same conventions as the CLI: stable and latest refer to the latest stable release, beta refers to the latest beta and falls back to stable, dev tracks the development branch and YEAR.MONTH tags (e.g. 2025.4) pin a specific release series[1]. Use a pin if an upstream release breaks your build.
3. Understanding the GitHub Actions workflows
The ci.yml workflow compiles the firmware nightly (via a cron schedule) and for each pull request. It uses a matrix over the YAML file names and over two ESPHome versions (stable and beta). Compilation is performed by the esphome/build-action GitHub Action. According to its README, this action takes a YAML file and produces firmware binaries and a partial manifest file used by ESP Web Tools[3]. If you need to adjust the build process, modify the file list or the esphome-version list in the matrix within .github/workflows/ci.yml.
The pr_test.yml workflow runs whenever a pull request is opened or updated. It lints YAML files with yamllint using the config at .github/yamllint.yml and then calls the ESPHome build action on the configuration. Always run yamllint locally before pushing changes.
On publishing a release, publish‑firmware.yml and publish‑pages.yml build and attach firmware binaries to the GitHub release and update the GitHub Pages site. These workflows rely on the esphome/workflows composite actions, which require you to specify the files (YAML configuration) and esphome-version in the input. If builds start failing after an ESPHome release, pin the version here to a known working release (for example, 2025.4.0).
4. Working with the ESPHome configuration
The main configuration file begins with a substitutions section. These variables customise your device name and calibration:
devicename – must be a lowercase string without dashes. This value forms part of the Wi‑Fi access point SSID and must also be unique on your network.
device_description – free‑form description of the device.
project_version – used for ESPHome’s project metadata.
update_interval – how often sensors update. Use a shorter interval (e.g. 1min) when calibrating sensors.
moisture_min, moisture_max, conductivity_min and conductivity_max – calibration points for the soil moisture and conductivity sensors. ESPHome’s calibrate_linear filter maps the raw sensor readings to real values by fitting a linear function. According to the documentation, you provide measured→true pairs of values, and at least two points are required; the filter will compute a line through them[4]. The default values assume the sensor outputs ~2.82 V in dry soil and ~1.39 V in water. Adjust these substitutions after performing your own calibration.
Optional features are disabled by default and can be enabled by uncommenting entries in the packages: section:
bluetooth – enables the ESP32 Bluetooth proxy using esp32_ble_tracker and bluetooth_proxy components. This is useful if you want your device to act as a Bluetooth bridge for Home Assistant.
waterpump – controls a pump via GPIO19 using a bang‑bang climate controller. Adjust the default_target_temperature_low and default_target_temperature_high values to your desired moisture thresholds.
text_sensors – publishes diagnostic information such as the installed project version and ESPHome version.
dht – reads temperature and humidity from a DHT sensor attached to pin 16.
bme280 – reads temperature, humidity and pressure from a BME280 sensor on the I²C bus at address 0x77.
battery – monitors battery voltage and percentage on pin 33. A multiplication factor of 2.0 is applied to account for voltage dividers.
deepsleep – enables deep sleep with configurable run_duration and sleep_duration. When you uncomment this, you must set these substitutions in LILYGO-T-Higrow-ESP32.yaml because ESPHome will otherwise fail to parse the configuration.
If you need to change the ESP32 board or framework, edit the esp32: block. The default board is lolin_d32 using the ESP‑IDF framework. Some sensors (e.g. Bluetooth proxy) may require the Arduino framework instead; if you encounter build errors related to Bluetooth, set:
esp32:   board: lolin_d32   framework:     type: arduino
You can find the list of supported boards in the ESPHome documentation. Changing the framework or board may affect pin assignments; adjust GPIO numbers accordingly.
5. Linting and coding conventions
The YAML files in this project follow standard ESPHome style:
Indent by two spaces per level. Keep it within the yaml lint specifics and never go over or under.
Use lowercase keys and strings where possible. Values in the substitutions section should be quoted if they contain special characters.
Wrap long lines for readability, but avoid trailing spaces.
Keep packages: entries alphabetically sorted. When adding a new component, create a separate YAML file in common/ and include it from the main file.
Run yamllint before committing changes:
yamllint -c .github/yamllint.yml LILYGO-T-Higrow-ESP32.yaml common/
6. Pull request and commit guidelines
When making changes:
Describe your change clearly – mention what feature you added or bug you fixed and why. If relevant, link to issues or discussions.
Update documentation – if you add new substitutions or components, document them in README.md and, if necessary, update this file.
Test locally – compile the firmware with the ESPHome CLI locally before pushing; ensure that both stable and beta builds succeed. The ESPHome build action will otherwise fail in CI.
Keep commits focused – avoid bundling unrelated changes. This makes reviewing easier.
Respect licensing – this project is GPL‑2.0 licensed; ensure contributions are compatible.
7. Troubleshooting common build failures
Component not found – if the build action fails with an error about an unknown component (for example, esp32_ble_tracker), ensure that the correct ESPHome version is used. Some components exist only in beta releases. Adjust the esphome-version in ci.yml or pin a specific release via the CLI --version option.
Framework conflicts – errors mentioning undefined reference or Bluetooth init failed may indicate that the selected framework is incompatible with a component. Switch between esp-idf and arduino frameworks as noted above.
Invalid calibration values – when customising the moisture_* or conductivity_* substitutions, supply valid floating point numbers. The calibrate_linear filter requires at least two datapoints[4]; providing only one will cause ESPHome to emit an error.
Out‑of‑memory – the esp32 board may run out of memory if multiple features are enabled simultaneously. Consider disabling optional features (e.g. Web server, Bluetooth proxy) or using a board with more RAM (e.g. esp32dev with PSRAM).
Following the instructions in this guide should help you diagnose and resolve most build issues. For further reference, consult the ESPHome documentation and the README for the esphome/build-action. The build action compiles a YAML file into firmware and outputs the resulting binaries along with a manifest file[3]. If you encounter issues beyond those listed here, search the ESPHome documentation or open an issue in this repository with the error log.
