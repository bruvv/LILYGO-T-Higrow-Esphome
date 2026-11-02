ESPHome firmware for the LILYGO T-Higrow WIFI Plant Sensor

![LILYGO-T-Higrow-ESP32-Soil-Tester-DHT11-BME280-Garden-Flowers-Temperature-Moisture-Sensor-WiFi-Bluetooth-Wireless jpg_Q90](https://user-images.githubusercontent.com/3063928/206154094-ab7eba28-10b1-4b91-85e5-5729495d6a8d.jpg)

![183286657-824a0e7f-a140-4d8e-8d6a-387070419dfd](https://user-images.githubusercontent.com/3063928/206154221-49a0d3ce-1850-4154-9039-1633d4962cd5.png)

# How to install esphome to the lilygo T-HiGrow wifi plant sensor

You can use the blue button "connect" below to install the pre-built firmware directly to your device via USB from your web browser.

Afterwards you can set up Wi-Fi and add your device to Home Assistant from this same web page. Make sure that it is on the same network as home-assistant is and it will connect automatically with the api of the plantsensor.
<esp-web-install-button manifest="firmware/lilgo-t-higrow-esp32.manifest.json"></esp-web-install-button>

<!-- <script type="module" src="https://unpkg.com/esp-web-tools@10/dist/web/install-button.js?module"></script>
<!-- <esp-web-install-button manifest="./lilygo-t-higrow-manifest.json"></esp-web-install-button> -->

<script type="module" src="https://unpkg.com/esp-web-tools/dist/web/install-button.js?module"></script>

To enable the flower-card in home-assistant:

1. Get - [OpenPlantBook API](https://open.plantbook.io)
2. Install [HACS](https://hacs.xyz/docs/setup/download)
3. Install [Homeassistant Plantbook integration](https://github.com/Olen/homeassistant-plant)
4. Install [Homeassistant Plantbook API integration](https://github.com/Olen/home-assistant-openplantbook)
5. Install [Homeassistant Flower card](https://github.com/Olen/lovelace-flower-card/tree/new_plant)

# How to calibrate the LILYGO T-Higrow Wi-Fi Plant Sensor

Calibration is controlled by substitutions. You no longer need to edit `common/plantsensors.yaml` or comment out any filters. Use a local ESPHome configuration after adopting the device.

1. In your device's `substitutions:`, set `calibration_mode: true` and `update_interval: 10s`, then flash the device.
2. Let the sensor dry, inspect its **Soil Moisture** and **Soil Fertilizer Index** readings (now displayed as volts), and record their dry voltages. Keep the electronic section dry.
3. Wet only the probe portion to the indicated immersion line, allow readings to stabilize, and record both wet voltages.
4. Set `moisture_min` to the dry moisture voltage, `moisture_max` to the wet moisture voltage, `conductivity_min` to the dry fertilizer voltage, and `conductivity_max` to the wet fertilizer voltage.
5. Restore `calibration_mode: false` and flash again. The values now report relative percentages clamped from 0 to 100.

```yaml
substitutions:
  calibration_mode: false
  moisture_min: "2.82"       # example dry voltage
  moisture_max: "1.39"       # example wet voltage
  conductivity_min: "0.075" # example dry voltage
  conductivity_max: "0.25"  # example wet voltage
```

**Important:** The fertilizer percentage is a relative index, not a validated electrical conductivity measurement in µS/cm. The BH1750 reads lux directly (default factor 1.0). The USB installer has no open fallback access point; reconfigure Wi-Fi using USB Improv or your locally secured recovery AP.

For tested BME280, battery, watering and local-security profiles, see the [README](https://github.com/bruvv/LILYGO-T-Higrow-Esphome#safety-accuracy-and-power-profiles-2026).
