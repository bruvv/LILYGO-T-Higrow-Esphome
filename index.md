# About

ESPHome firmware for a Lilygo T-Higrow wifi plant sensor

![LILYGO-T-Higrow-ESP32-Soil-Tester-DHT11-BEM280-Garden-Flowers-Temperature-Moisture-Sensor-WiFi-Bluetooth-Wireless jpg_Q90](https://user-images.githubusercontent.com/3063928/206154094-ab7eba28-10b1-4b91-85e5-5729495d6a8d.jpg)

![183286657-824a0e7f-a140-4d8e-8d6a-387070419dfd](https://user-images.githubusercontent.com/3063928/206154221-49a0d3ce-1850-4154-9039-1633d4962cd5.png)

# Installation

You can use the buttons below to install the pre-built firmware directly to your device via USB from your web browser.

Afterwards you can set up Wi-Fi and add your device to Home Assistant from this same web page. Make sure that it is on the same network as home-assistant is and it will connect automatically with the api of the plantsensor.

To enable the flower-card in home-assistant:

1. Get - [OpenPlantBook API](https://open.plantbook.io)
2. Install [HACS](https://hacs.xyz/docs/setup/download)
3. Install [Homeassistant Plantbook intergration](https://github.com/Olen/homeassistant-plant)
4. Install [Homeassistant Plantbook api intergration](https://github.com/Olen/home-assistant-openplantbook)
5. Install [Homeassistant Flower card](https://github.com/Olen/lovelace-flower-card/tree/new_plant)

## LilyGO T-Higrow wifi plant sensor

<esp-web-install-button manifest="./air-quality-monitor-t-display-manifest.json"></esp-web-install-button>

<script type="module" src="https://unpkg.com/esp-web-tools@9.0.5/dist/web/install-button.js?module"></script>
