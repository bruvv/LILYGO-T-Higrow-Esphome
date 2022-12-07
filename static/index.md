# About

ESPHome firmware for a Lilygo T-Higrow wifi plant sensor

![LILYGO-T-Higrow-ESP32-Soil-Tester-DHT11-BEM280-Garden-Flowers-Temperature-Moisture-Sensor-WiFi-Bluetooth-Wireless jpg_Q90](https://user-images.githubusercontent.com/3063928/206154094-ab7eba28-10b1-4b91-85e5-5729495d6a8d.jpg)

![183286657-824a0e7f-a140-4d8e-8d6a-387070419dfd](https://user-images.githubusercontent.com/3063928/206154221-49a0d3ce-1850-4154-9039-1633d4962cd5.png)

# How to install esphome to the lilygo T-HiGrow wifi plant sensor

You can use the blue button "connect" below to install the pre-built firmware directly to your device via USB from your web browser.

Afterwards you can set up Wi-Fi and add your device to Home Assistant from this same web page. Make sure that it is on the same network as home-assistant is and it will connect automatically with the api of the plantsensor.

<esp-web-install-button manifest="./air-quality-monitor-t-display-manifest.json"></esp-web-install-button>

<script type="module" src="https://unpkg.com/esp-web-tools@9.0.5/dist/web/install-button.js?module"></script>

To enable the flower-card in home-assistant:

1. Get - [OpenPlantBook API](https://open.plantbook.io)
2. Install [HACS](https://hacs.xyz/docs/setup/download)
3. Install [Homeassistant Plantbook intergration](https://github.com/Olen/homeassistant-plant)
4. Install [Homeassistant Plantbook api intergration](https://github.com/Olen/home-assistant-openplantbook)
5. Install [Homeassistant Flower card](https://github.com/Olen/lovelace-flower-card/tree/new_plant)

# How to calibrate the lilygo T-HiGrow wifi plant sensor

First make sure you can flash your current sensor, otherwise you cannot continu.
Start with opening the `plantsensors.yaml` file to change some settings.

Find the following comments:

` # comment when calibrating`

Place a comment infront of that line. For example:

`unit_of_measurement: '%' # comment for calibration`

will become:

`# unit_of_measurement: '%' # comment for calibration`

Do this for every line you find.

Find the `# uncomment for calibration` line and change it. For example:

`# unit_of_measurement: "V" # uncomment for calibration`

Becomes:

`unit_of_measurement: "V" # uncomment for calibration`

Now do this for every line you find in `plantsensors.yaml`.

After you did this, it is time to generate the configuration again, for this you need ESPHOME. You can do this in the addon in home assistant or, much quicker, on your own PC with the following command, but first insert your sensor with USB to your PC.

`esphome run LILYGO-T-Higrow-ESP32.yaml`

This will compile and flash the file. While it is compiling get some glass with water. After you have flashed the file you will see a log output. This is great! We need it for the measurements. Make sure to clean the sensor and make sure it is totally dry as we need a dry measurement first.

![IMG_20221207_154457](https://user-images.githubusercontent.com/3063928/206223822-7d18fa3e-08d3-46d3-9e20-9d20245d3f73.jpg)

After drying the sensor look in the log file for the measurements, look for the following 2 lines:

```
[15:46:50][D][sensor:127]: 'lilygo_higrow_plant_sensor Soil Conductivity': Sending state 0.07500 V with 2 decimals of accuracy
[15:46:46][D][sensor:127]: 'lilygo_higrow_plant_sensor Soil Moisture': Sending state 2.83500 V with 2 decimals of accuracy
```

Note the: `0.07500 V` and `2.83500 V`

Now let the sensor run for at least 10 minutes and let nothing touch it!

So after 10 minutes the measurment for Conductivity stayed: `0.07500 V` and Moisture stayed: `2.83500 V` we can write that in our yaml!

Open `plantsensors.yaml` again and find the following:

```
    # filters: # comment when calibrating
      # - calibrate_linear: # comment when calibrating
          # Map 0.0 (from sensor) to 0.0 (true value)
          # - 0.075 -> 0.0 # comment when calibrating
          # - 0.25 -> 100.0 # comment when calibrating
```

We are looking for these lines:

```
Moisture:
# - 2.82 -> 0.0 # comment when calibrating

Conductivity:
# - 0.075 -> 0.0 # comment when calibrating
```

this is means, `2.82` and `0.075` are the measurements when it is actually 0. We adjust this to what we found during our calibration. So for our Moisture we adjust it to:

`# - 2.835 -> 0.0 # comment when calibrating`

Now we have to change the max reading of the sensor, this means it is water time! Put the sensor in the water up till the white line. So make very sure not to put it in to much!

![IMG_20221207_162203](https://user-images.githubusercontent.com/3063928/206223859-1298feb0-ba4f-43c8-bac1-8a1610380c3b.jpg)

So we now look for the higher numbers when it is (half) submerged, again look in the log files and note the voltage readings as previously explained:

```
[16:22:22][D][sensor:127]: 'lilygo_higrow_plant_sensor Soil Conductivity': Sending state 0.24400 V with 2 decimals of accuracy
[16:22:25][D][sensor:127]: 'lilygo_higrow_plant_sensor Soil Moisture': Sending state 1.37300 V with 2 decimals of accuracy
```

So we write them down in the `plantsensors.yaml` again but now the higher numbers:

```
Moisture:
# - 1.373 -> 100.0 # comment when calibrating

Conductivity:
# - 0.244 -> 100.0 # comment when calibrating
```

After you writen down the correct numbers it is time to uncomment the commented section for example:

```
  # Fertilizer sensor
  - platform: adc
    pin: GPIO34
    name: '${devicename} Soil Conductivity'
    icon: 'mdi:flower'
    update_interval: ${update_interval}
    accuracy_decimals: 2 # comment for calibration
    unit_of_measurement: 'µS/cm' # comment when calibrating
    # unit_of_measurement: "V" # uncomment for raw data
    filters: # comment when calibrating
      - calibrate_linear: # comment when calibrating
          # Map 0.0 (from sensor) to 0.0 (true value)
          - 0.075 -> 0.0 # comment when calibrating
          - 0.244 -> 100.0 # comment when calibrating
```

Reflash it again with the previous command: `esphome run LILYGO-T-Higrow-ESP32.yaml` and it is now calibrated!

You can also calibrate the temperature and humidty sensors, please read the `dht.yaml` or `bme280.yaml` to set the correct offsets.
