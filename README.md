# ESPHome firmware for a LILYGO T-Higrow WIFI Plant Sensor

[![Build](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/actions/workflows/build.yml/badge.svg)](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/actions/workflows/build.yml)
[![License](https://img.shields.io/github/license/bruvv/LILYGO-T-Higrow-Esphome.svg)](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/LICENSE)

This [ESPHome](https://esphome.io/) configuration builds firmware for the LILYGO T-Higrow plantsensor. It monitors:

- Soil humidity
- Soil Fertilizer
- Lux
- Temperature
- Humidity

With a beatiful dashboard card:

![Plantflower card](https://user-images.githubusercontent.com/203184/183286657-824a0e7f-a140-4d8e-8d6a-387070419dfd.png)

# Requirements

- [Plant sensor itself](https://s.click.aliexpress.com/e/_DlYOcRZ)
- [ESPHome](https://esphome.io/)

Optionally:

- [Water pump](https://s.click.aliexpress.com/e/_DdaMnMB)
- LiPo or Li-Ion battery
- [HACS](https://hacs.xyz/docs/setup/download/)
- [OpenPlantBook API](https://open.plantbook.io/)
- [Homeassistant Plantbook intergration](https://github.com/Olen/homeassistant-plant)
- [Homeassistant Plantbook api intergration](https://github.com/Olen/home-assistant-openplantbook)
- [Homeassistant Flower card](https://github.com/Olen/lovelace-flower-card/tree/new_plant)

# Modularity

This is a modular ESPHome configuration split up in various YAML files that you can import as [packages](https://esphome.io/guides/configuration-types.html#packages).

You can find these in the directory [common](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/tree/main/common):

[battery.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/battery.yaml)

If you bought a battery and hooked it up to the esp then you will need to enable this. The default battery will run for 12 hours with deep sleep enabled.

[bluetooth.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/bluetooth.yaml)

This will enable bluetooth (proxy) so you can have the bluetooth functionality enabled

[bme280.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/bme280.yaml)

If you bought the bme280 sensor option please enable this.

[Deepsleep.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/deepsleep.yaml)

If you want to run the battery it is wise to enable this so it will sleep.

[dht.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/dht.yaml)

This enables the external temperature sensor that is connected to the board itself to measure the surrounding temperature and humidity.

[plantsensors.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/plantsensors.yaml)

This sets up the sensors that go into the soil itself.

[text_sensors.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/text_sensors.yaml)

When you want to enable the inbuild text_sensors enable this, it will output usefull stuff to home assistant.

[waterpump.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/waterpump.yaml)

If you bought the optional Waterpump please enable this.

# Usage

To use this configuration, create a YAML file with:

- substitutions for all pin numbers used by the components, your devices name, platform and board and parameters like update intervals.
- packages that include the relevant YAML files in the `common` directory.
- [LILYGO-T-Higrow-ESP32.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/LILYGO-T-Higrow-ESP32.yaml) for the NodeMCU v2 ESP8266 with MH-Z19B

After this, flash the firmware to your device, e.g. with:

```
esphome run LILYGO-T-Higrow-ESP32.yaml
```

After you have added your device to Home Assistant ESPHome Integration, the air quality measurements are available in Home Assistant.

To enable the flower-card in home-assistant:

1. Get - [OpenPlantBook API](https://open.plantbook.io/)
2. Install [HACS](https://hacs.xyz/docs/setup/download/)
3. Install [Homeassistant Plantbook intergration](https://github.com/Olen/homeassistant-plant)
4. Install [Homeassistant Plantbook api intergration](https://github.com/Olen/home-assistant-openplantbook)
5. Install [Homeassistant Flower card](https://github.com/Olen/lovelace-flower-card/tree/new_plant)

# Web-based installation

If you have built an example configurations, you can install the latest version of the firmware on your LILYGO-T-Higrow wifi plant sensor from the [installation page](https://bruvv.github.io/LILYGO-T-Higrow-Esphome) via USB, as well as setting up Wi-Fi and adding the device to Home Assistant. This requires a web browser that supports [WebSerial](https://caniuse.com/web-serial) (which is a recent Chrome, Edgeor Opera).

# Customizations

If you successfully created a customization, please contribute this with a [pull request], ideally with an example configuration.
