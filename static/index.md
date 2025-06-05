ESPHome firmware for the LILYGO T-Higrow WIFI Plant Sensor

![LILYGO-T-Higrow-ESP32-Soil-Tester-DHT11-BEM280-Garden-Flowers-Temperature-Moisture-Sensor-WiFi-Bluetooth-Wireless jpg_Q90](https://user-images.githubusercontent.com/3063928/206154094-ab7eba28-10b1-4b91-85e5-5729495d6a8d.jpg)

![183286657-824a0e7f-a140-4d8e-8d6a-387070419dfd](https://user-images.githubusercontent.com/3063928/206154221-49a0d3ce-1850-4154-9039-1633d4962cd5.png)

# How to install esphome to the lilygo T-HiGrow wifi plant sensor

You can use the blue button "connect" below to install the pre-built firmware directly to your device via USB from your web browser.

Afterwards you can set up Wi-Fi and add your device to Home Assistant from this same web page. Make sure that it is on the same network as home-assistant is and it will connect automatically with the api of the plantsensor.
<esp-web-install-button manifest="firmware/lilgo-t-higrow-esp32.manifest.json"></esp-web-install-button>

<!-- <script type="module" src="https://unpkg.com/esp-web-tools@10/dist/web/install-button.js?module"></script> -->
<!-- <esp-web-install-button manifest="./lilygo-t-higrow-manifest.json"></esp-web-install-button>

<script type="module" src="https://unpkg.com/esp-web-tools/dist/web/install-button.js?module"></script> -->

To enable the flower-card in home-assistant:

1. Get - [OpenPlantBook API](https://open.plantbook.io)
2. Install [HACS](https://hacs.xyz/docs/setup/download)
3. Install [Homeassistant Plantbook intergration](https://github.com/Olen/homeassistant-plant)
4. Install [Homeassistant Plantbook api intergration](https://github.com/Olen/home-assistant-openplantbook)
5. Install [Homeassistant Flower card](https://github.com/Olen/lovelace-flower-card/tree/new_plant)

# How to Calibrate the LILYGO T-Higrow Wi-Fi Plant Sensor

Before starting, make sure you’re able to flash your sensor — otherwise, calibration won’t be possible.

---

## Step 1: Edit `plantsensors.yaml`

Open the `plantsensors.yaml` file and locate lines marked with:

```yaml
# comment when calibrating
```

You need to **comment out** those lines. For example:

**Original:**

```yaml
unit_of_measurement: '%' # comment for calibration
```

**Becomes:**

```yaml
# unit_of_measurement: '%' # comment for calibration
```

Repeat this for every line that includes `# comment when calibrating`.

Then, locate lines marked like this:

```yaml
# unit_of_measurement: "V" # uncomment for calibration
```

And **uncomment** them like so:

```yaml
unit_of_measurement: "V" # uncomment for calibration
```

Repeat this for each similar line in the file.

---

## Step 2: Flash the Firmware

Once you've made the changes:

1. Plug in your T-Higrow sensor via USB.
2. Open a terminal and run the following:

```bash
esphome run LILYGO-T-Higrow-ESP32.yaml
```

> You can do this through Home Assistant (ESPHome Addon), but flashing via your PC is usually faster.

While it's compiling, grab a glass of water — you’ll need it later.

---

## Step 3: Get a Dry Measurement

After flashing:

1. **Clean and dry** the sensor completely.
2. Watch the log output. Look for lines like these:

```
[15:46:50][D][sensor:127]: '... Soil Conductivity': Sending state 0.07500 V
[15:46:46][D][sensor:127]: '... Soil Moisture': Sending state 2.83500 V
```

> **Write down the values** — these are your **dry (minimum)** readings.

![Dry Measurement](https://user-images.githubusercontent.com/3063928/206223822-7d18fa3e-08d3-46d3-9e20-9d20245d3f73.jpg)

Let the sensor run untouched for 10 minutes, then confirm the readings are stable.

---

## Step 4: Update Your YAML with Dry Values

Open `LILYGO-T-Higrow-ESP32.yaml` and set the dry values you just recorded:

```yaml
moisture_min: "2.83"
conductivity_min: "0.075"
```

---

## Step 5: Get a Wet Measurement

Now submerge the sensor **up to the white line** in water. Don’t go too deep.

![Wet Measurement](https://user-images.githubusercontent.com/3063928/206223859-1298feb0-ba4f-43c8-bac1-8a1610380c3b.jpg)

Again, check the log output for readings like:

```
[16:22:22][D][sensor:127]: '... Soil Conductivity': Sending state 0.24400 V
[16:22:25][D][sensor:127]: '... Soil Moisture': Sending state 1.37300 V
```

These are your **wet (maximum)** readings.

---

## Step 6: Update Your YAML with Wet Values

Add the new max values to your config:

```yaml
moisture_max: "1.373"
conductivity_max: "0.244"
```

---

## Step 7: Re-enable Sensor Filtering

Now that calibration is done, **revert the comments** in `plantsensors.yaml`. For example:

```yaml
# Fertilizer sensor
- platform: adc
  pin: GPIO34
  name: '${devicename} Soil Conductivity'
  icon: 'mdi:flower'
  update_interval: ${update_interval}
  accuracy_decimals: 2
  unit_of_measurement: 'µS/cm'
  # unit_of_measurement: "V" # uncomment for raw data
  filters:
    - calibrate_linear:
        - ${conductivity_min} -> 0.0
        - ${conductivity_max} -> 100.0
```

---

## Step 8: Reflash the Calibrated Firmware

Reflash with:

```bash
esphome run LILYGO-T-Higrow-ESP32.yaml
```

You're now running with calibrated sensor values!

---

## Bonus: Temperature & Humidity Calibration

If you're using temperature/humidity sensors, open either:

- `dht.yaml` (for DHT11/DHT22)
- `bme280.yaml` (for BME280)

…and adjust the offsets in those files to calibrate them as well.
