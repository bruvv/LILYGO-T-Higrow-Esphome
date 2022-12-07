###########################
ESPHome Lilygo T-Higrow plant sensor
###########################

.. image:: https://github.com/bruvv/LILYGO-T-Higrow-ESP32/workflows/Build/badge.svg
   :target: https://github.com/bruvv/LILYGO-T-Higrow-ESP32/actions
   :alt: Continuous integration

.. image:: https://img.shields.io/github/license/bruvv/LILYGO-T-Higrow-ESP32.svg
   :target: https://github.com/bruvv/LILYGO-T-Higrow-ESP32/blob/main/LICENSE
   :alt: License

This `ESPHome <https://esphome.io/>`_ configuration builds firmware for the LILYGO T-Higrow plantsensor. It monitors:

- Soil humidity
- Soil Fertilizer
- Lux
- Temperature
- Humidity

With a beatiful dashboard card:

.. image:: https://user-images.githubusercontent.com/203184/183286657-824a0e7f-a140-4d8e-8d6a-387070419dfd.png
   :alt: Plantflower card


************
Requirements
************

- `Plant sensor itself <https://s.click.aliexpress.com/e/_DlYOcRZ>`_
- ESPHome

Optionally:

- `Water pump <https://s.click.aliexpress.com/e/_DdaMnMB>`_
- LiPo or Li-Ion battery
- `HACS <https://hacs.xyz/docs/setup/download/>`_
- `OpenPlantBook API <https://open.plantbook.io/>`_
- `Homeassistant Plantbook intergration <https://github.com/Olen/homeassistant-plant>`_
- `Homeassistant Plantbook api intergration <https://github.com/Olen/home-assistant-openplantbook>`_
- `Homeassistant Flower card <https://github.com/Olen/lovelace-flower-card/tree/new_plant>`_

**********
Modularity
**********

This is a modular ESPHome configuration split up in various YAML files that you can import as `packages <https://esphome.io/guides/configuration-types.html#packages>`_. You can find these in the directory `common <https://github.com/bruvv/LILYGO-T-Higrow-ESP32/tree/main/common>`_:

`battery.yaml <https://github.com/bruvv/LILYGO-T-Higrow-ESP32/blob/main/common/battery.yaml>`_
  If you bought a battery and hooked it up to the esp then you will need to enable this. The default battery will run for 12 hours with deep sleep enabled.
`bluetooth.yaml <https://github.com/bruvv/LILYGO-T-Higrow-ESP32/blob/main/common/bluetooth.yaml>`_
  This will enable bluetooth (proxy) so you can have the bluetooth functionality enabled
`bme280.yaml <https://github.com/bruvv/LILYGO-T-Higrow-ESP32/blob/main/common/bme280.yaml>`_
  If you bought the bme280 sensor option please enable this.
`Deepsleep.yaml <https://github.com/bruvv/LILYGO-T-Higrow-ESP32/blob/main/common/deepsleep.yaml>`_
  If you want to run the battery it is wise to enable this so it will sleep.
`dht.yaml <https://github.com/bruvv/LILYGO-T-Higrow-ESP32/blob/main/common/dht.yaml>`_
  This enables the external temperature sensor that is connected to the board itself to measure the surrounding temperature and humidity.
`plantsensors.yaml <https://github.com/bruvv/LILYGO-T-Higrow-ESP32/blob/main/common/plantsensors.yaml>`_
  This sets up the sensors that go into the soil itself.
`text_sensors.yaml <https://github.com/bruvv/LILYGO-T-Higrow-ESP32/blob/main/common/text_sensors.yaml>`_
  When you want to enable the inbuild text_sensors enable this, it will output usefull stuff to home assistant.
`waterpump.yaml <https://github.com/bruvv/LILYGO-T-Higrow-ESP32/blob/main/common/waterpump.yaml>`_
  If you bought the optional Waterpump please enable this.

*****
Usage
*****

To use this configuration, create a YAML file with:

- substitutions for all pin numbers used by the components, your device's name, platform and board and parameters like update intervals.
- packages that include the relevant YAML files in the ``common`` directory.

There are three example configurations in this repository:

- `LILYGO-T-Higrow-ESP32.yaml <https://github.com/bruvv/LILYGO-T-Higrow-ESP32/blob/main/LILYGO-T-Higrow-ESP32.yaml>`_ for the NodeMCU v2 ESP8266 with MH-Z19B

After this, flash the firmware to your device, e.g. with:

.. code-block:: console

  esphome run LILYGO-T-Higrow-ESP32.yaml

After you have added your device to Home Assistant's ESPHome integration, the air quality measurements are available in Home Assistant.

To enable the flower-card in home-assistant:
  1. Get - `OpenPlantBook API <https://open.plantbook.io/>`_
  2. Install `HACS <https://hacs.xyz/docs/setup/download/>`_
  3. Install `Homeassistant Plantbook intergration <https://github.com/Olen/homeassistant-plant>`_
  4. Install `Homeassistant Plantbook api intergration <https://github.com/Olen/home-assistant-openplantbook>`_
  5. Install `Homeassistant Flower card <https://github.com/Olen/lovelace-flower-card/tree/new_plant>`_

**********************
Web-based installation
**********************

If you have built an example configurations, you can install the latest version of the firmware on your LILYGO-T-Higrow wifi plant sensor from the `installation page <https://bruvv.github.io/LILYGO-T-Higrow-ESP32>`_ via USB, as well as setting up Wi-Fi and adding the device to Home Assistant. This requires a web browser that supports `Web Serial <https://caniuse.com/web-serial>`_ (which is a recent Chrome, Edge or Opera).

**************
Customizations
**************

If you successfully created a customization, please contribute this with a `pull request`_, ideally with an example configuration.
