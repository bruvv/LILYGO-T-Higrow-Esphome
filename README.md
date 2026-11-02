# ESPHome firmware for a LILYGO T-Higrow WIFI Plant Sensor

[![License](https://img.shields.io/github/license/bruvv/LILYGO-T-Higrow-Esphome.svg)](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/LICENSE)

This [ESPHome](https://esphome.io/) configuration builds firmware for the LILYGO T-Higrow plantsensor. It monitors:

- Soil humidity
- Soil Fertilizer
- Lux
- Temperature
- Humidity

With a beautiful dashboard card:

![Plantflower card](https://user-images.githubusercontent.com/203184/183286657-824a0e7f-a140-4d8e-8d6a-387070419dfd.png)

# Requirements

- [Plant sensor](https://s.click.aliexpress.com/e/_ongLgQM) itself
- [ESPHome](https://esphome.io/)

Optionally:

- [Water pump](https://s.click.aliexpress.com/e/_DefUZbV) (is not sold any more :( )
- [Long USB-C Cable](https://s.click.aliexpress.com/e/_oFPnq9a)
- [Cheap USB charger](https://s.click.aliexpress.com/e/_ombe20g)
- LiPo or Li-Ion battery
- [HACS](https://hacs.xyz/docs/setup/download/)
- [OpenPlantBook API](https://open.plantbook.io/)
- [Homeassistant Plantbook integration](https://github.com/Olen/homeassistant-plant)
- [Homeassistant Plantbook API integration](https://github.com/Olen/home-assistant-openplantbook)
- [Homeassistant Flower card](https://github.com/Olen/lovelace-flower-card/tree/new_plant)

## How to install (easy)

This project automates the building process. So all you need to do is open Chrome, Edge or Opera and go to the [installation page](https://bruvv.github.io/LILYGO-T-Higrow-Esphome). Connect the ESP32 to your computer via USB and read the instructions on that page.

## How to install (expert)

To use this configuration, adjust the [LILYGO-T-Higrow-ESP32.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/LILYGO-T-Higrow-ESP32.yaml) and change the `Substitutions`. If you want to adjust specific settings or do a [calibration](https://bruvv.github.io/LILYGO-T-Higrow-Esphome/#how-to-calibrate-the-lilygo-t-higrow-wifi-plant-sensor), the relevant YAML files are in the `common` directory.

After this, flash the firmware to your device, e.g. with:

```
esphome run LILYGO-T-Higrow-ESP32.yaml
```

After you have added your device to Home Assistant ESPHome Integration, the sensors are available in Home Assistant.

## Enable the Flower Card

To enable the `flower-card` in home-assistant:

1. Get - [OpenPlantBook API](https://open.plantbook.io/)
2. Install [HACS](https://hacs.xyz/docs/setup/download/)
3. Install [Homeassistant Plantbook integration](https://github.com/Olen/homeassistant-plant)
4. Install [Homeassistant Plantbook API integration](https://github.com/Olen/home-assistant-openplantbook)
5. Install [Homeassistant Flower card](https://github.com/Olen/lovelace-flower-card/tree/new_plant)

# Modularity

This is a modular ESPHome configuration split up in various YAML files that you can import as [packages](https://esphome.io/guides/configuration-types.html#packages).

You can find these in the directory [common](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/tree/main/common):

[battery.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/battery.yaml)

If you bought a battery and hooked it up to the esp then you will need to uncomment `battery` in the `packages` section in [LILYGO-T-Higrow-ESP32.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/LILYGO-T-Higrow-ESP32.yaml). Battery runtime depends on cell capacity, radio activity and measurement frequency. For battery use, also enable `deepsleep`, set `update_interval: 10s`, and remove the Bluetooth proxy. See the battery profile below.

[bluetooth.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/bluetooth.yaml)

Bluetooth proxy is included in the USB-powered default firmware. It scans only when Home Assistant is connected, and uses a reduced scan window. Disable the BLE tracker/proxy and its API hooks when using a battery.

[bme280.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/bme280.yaml)

If you bought the bme280 sensor option please uncomment `bme280`.

[Deepsleep.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/deepsleep.yaml)

If you want to run the battery it is wise to enable this so it will sleep. You can do this in the [LILYGO-T-Higrow-ESP32.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/LILYGO-T-Higrow-ESP32.yaml) by uncommenting the `deepsleep` line.

[dht.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/dht.yaml)

This enables the external temperature sensor that is connected to the board itself to measure the surrounding temperature and humidity.

[plantsensors.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/plantsensors.yaml)

This sets up the sensors that go into the soil itself.

[text_sensors.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/text_sensors.yaml)

When you want to enable the inbuilt text_sensors enable this, it will output useful stuff to Home Assistant.

[waterpump.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/common/waterpump.yaml)

If you have the optional pump, explicitly uncomment its package in [LILYGO-T-Higrow-ESP32.yaml](https://github.com/bruvv/LILYGO-T-Higrow-Esphome/blob/main/LILYGO-T-Higrow-ESP32.yaml). Automatic watering always starts disabled and requires a safe pump driver and independent physical leak protection.

# Customizations

If you successfully created a customization, please contribute this with a [pull request], ideally with an example configuration.

## Safety, accuracy and power profiles (2026)

### Soil readings

The soil moisture and **fertilizer index** are *relative* percentages, not lab-grade measurements. The fertilizer index is not an electrical conductivity value in µS/cm. The BH1750 component already measures lux; the default correction factor is `1.0`.

To calibrate an individual probe, override the substitutions from your adopted device configuration and briefly set `calibration_mode: true`. Record dry and wet **voltages**, then set `moisture_min` (dry voltage), `moisture_max` (wet voltage), `conductivity_min` and `conductivity_max`, and restore `calibration_mode: false`. The base configuration does not need to be edited or forked. Do not submerge the electronics, and do not treat the fertilizer index as an EC standard.

### Water pump

The pump is not part of the default build. If you opt in, a dedicated Home Assistant switch enables automatic watering, **disabled after every reboot**. A cycle is at most `5s`, followed by a `6h` cooldown. Only a fresh, valid soil reading below `20%` can trigger the pump; measurements above `40%` or invalid measurements stop it. These thresholds and times are substitutions. Provide a correctly rated pump driver, flyback protection, external power and a physical overflow/leak safeguard. The software is *not* an independent water safety mechanism.

### Battery and deep sleep

Enable both `battery.yaml` and `deepsleep.yaml` packages and set `update_interval: 10s` in your adopted configuration. Remove the Bluetooth proxy, tracker and their API scan hooks. The deep-sleep script forces fresh soil ADC samples on each wake, waits for the native API with a timeout, then returns to deep sleep. The maximum awake time defaults to `90s`; the nominal sleep interval is `60min`. Battery percentage is only a piecewise voltage estimate, not measured state of charge.

Example configurations for the battery, BME280, pump, and calibration options are in [tests](tests). They are compile-tested in CI.

### API security and local overrides

The shared web installer intentionally contains **no shared passwords or encryption keys**. It uses USB Improv for initial Wi-Fi provisioning and no longer advertises an unsecured fallback hotspot. Once adopted, use [examples/secure-home.yaml](examples/secure-home.yaml) as a reference for unique local API encryption, Wi-Fi credentials and an optional password-protected recovery AP. Keep values in your personal `secrets.yaml`, not this repository. A change to the API key must also be applied in Home Assistant.

To customize an installed device without forking, use a remote [ESPHome package](https://esphome.io/components/packages/) in your local device configuration, override its `substitutions`, and use `!extend` or `!remove` to modify packaged entities. For example, `sensor: [{id: !remove higrow_dht}]` removes the default DHT component when using BME280.

### Compatibility

The shared firmware targets ESPHome **2026.10.1**; CI compiles the default firmware and four optional profiles using that same version, with a non-blocking beta check. Release builds use the same pinned version. Physical verification of sensor calibration, pump electrical behavior and battery endurance remains hardware-specific.
