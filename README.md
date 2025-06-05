# ESPHome firmware for a LILYGO T-Higrow WIFI Plant Sensor

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

- [Plant sensor itself](https://s.click.aliexpress.com/e/_ongLgQM)
- [ESPHome](https://esphome.io/)

Optionally:

- [Water pump](https://s.click.aliexpress.com/e/_DefUZbV) (is not sold any more :( ))
- [Long USB-C Cable](https://s.click.aliexpress.com/e/_oFPnq9a)
- [Cheap USB charger](https://s.click.aliexpress.com/e/_ombe20g)
- LiPo or Li-Ion battery
- [HACS](https://hacs.xyz/docs/setup/download/)
- [OpenPlantBook API](https://open.plantbook.io/)
- [Homeassistant Plantbook intergration](https://github.com/Olen/homeassistant-plant)
- [Homeassistant Plantbook api intergration](https://github.com/Olen/home-assistant-openplantbook)
- [Homeassistant Flower card](https://github.com/Olen/lovelace-flower-card/tree/new_plant)

# How to install (easy)

This project automates the building process. So all you need to do is open Chrome, Edge or Opera and go to the [installation page](https://bruvv.github.io/LILYGO-T-Higrow-Esphome). Connect the ESP32 to your computer via USB and read the instructions on that page.

# How to install (expert)

To use this configuration, adjust the [LILYGO-T-Higrow-ESP32.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/LILYGO-T-Higrow-ESP32.yaml) and changes the `Subsitions`. If you want to adjust specific settings or do a [calbiration](https://bruvv.github.io/LILYGO-T-Higrow-Esphome/#how-to-calibrate-the-lilygo-t-higrow-wifi-plant-sensor), the relevant YAML files are in the `common` directory.

After this, flash the firmware to your device, e.g. with:

```
esphome run LILYGO-T-Higrow-ESP32.yaml
```

After you have added your device to Home Assistant ESPHome Integration, the sensors are available in Home Assistant.

To enable the flower-card in home-assistant:

1. Get - [OpenPlantBook API](https://open.plantbook.io/)
2. Install [HACS](https://hacs.xyz/docs/setup/download/)
3. Install [Homeassistant Plantbook intergration](https://github.com/Olen/homeassistant-plant)
4. Install [Homeassistant Plantbook api intergration](https://github.com/Olen/home-assistant-openplantbook)
5. Install [Homeassistant Flower card](https://github.com/Olen/lovelace-flower-card/tree/new_plant)

# Modularity

This is a modular ESPHome configuration split up in various YAML files that you can import as [packages](https://esphome.io/guides/configuration-types.html#packages).

You can find these in the directory [common](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/tree/main/common):

[battery.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/battery.yaml)

If you bought a battery and hooked it up to the esp then you will need to enable this in the [LILYGO-T-Higrow-ESP32.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/LILYGO-T-Higrow-ESP32.yaml). The default battery will run for 12 hours with deep sleep enabled.

[bluetooth.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/bluetooth.yaml)

This will enable bluetooth (proxy) so you can have the bluetooth functionality enabled. Disable when using battery.

[bme280.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/bme280.yaml)

If you bought the bme280 sensor option please enable this.

[Deepsleep.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/deepsleep.yaml)

If you want to run the battery it is wise to enable this so it will sleep. You can do this in the [LILYGO-T-Higrow-ESP32.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/LILYGO-T-Higrow-ESP32.yaml)

[dht.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/dht.yaml)

This enables the external temperature sensor that is connected to the board itself to measure the surrounding temperature and humidity.

[plantsensors.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/plantsensors.yaml)

This sets up the sensors that go into the soil itself.

[text_sensors.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/text_sensors.yaml)

When you want to enable the inbuild text_sensors enable this, it will output usefull stuff to home assistant.

[waterpump.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/waterpump.yaml)

If you bought the optional Waterpump please enable this in the [LILYGO-T-Higrow-ESP32.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/LILYGO-T-Higrow-ESP32.yaml)

# Customizations

If you successfully created a customization, please contribute this with a [pull request], ideally with an example configuration.
