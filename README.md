# home-data

A data visualisation project for data collected at home.

## Project Structure

The project offers the following main components:
- python script to collect data (in folder *sensor_script*)
- Flutter application to visualize data (in folder *home_data_flutter*)
- Node JS server to make data available to flutter application (in folder *server*)

### Data collection

The project includes a script ([based on this example](https://github.com/adafruit/Adafruit_CircuitPython_BME680)) to collect data for example on a Raspberry Pi, using a BME680 sensor. Said script is written in python. After cloning the project and [setting up the connection to the sensor](https://learn.adafruit.com/adafruit-bme680-humidity-temperature-barometic-pressure-voc-gas/python-circuitpython), the script can be started using the following command: `python3 bme680_com.py`

It will first conduct a burn in, to set the baseline for the Air Quality Index computation. [More info here.](https://github.com/pimoroni/bme680-python/blob/master/examples/indoor-air-quality.py)

After the 5 min burn in, data will be collected every 10 minutes and sent to a MongoDB server on the local network. [Basic setup instructions for MongoDB on a RaspberryPi can be found here.](https://www.mongodb.com/developer/how-to/mongodb-on-raspberry-pi/)

### Node JS Server

A simple node js server with [express js](https://expressjs.com/) is being used to query the MongoDB database upon request and answer with the data that has been collected in the last 24 hours.

The server can be started from within the server folder with the following command: `node index.js`

You'll need the following packages to run the server:
- expressjs
- mongoose

The server will connect to the MongoDB database and then accept requests on port 3001.

### Flutter Application

The flutter application provides a simple interface to display the data of the last 24 hours. A server request at `serverIP:3001/recentData` will return the data needed. This request will be fired upon start of the app and upon pull-to-refresh inside the app.

Screenshots of the app:

<img src="https://user-images.githubusercontent.com/47003752/149173881-804ca28a-0225-4f38-91f7-c80d43ac9d95.jpg" width="256" /><img src="https://user-images.githubusercontent.com/47003752/149173883-1a079ff9-1edb-4a7d-a839-c0d151855830.jpg" width="256" /><img src="https://user-images.githubusercontent.com/47003752/149173884-347f1f5e-5553-4a5b-af45-7b3cf5978aa9.jpg" width="256" /><img src="https://user-images.githubusercontent.com/47003752/149173876-9b98f863-b5c1-4c44-a804-b6976ecbe436.jpg" width="256" />

