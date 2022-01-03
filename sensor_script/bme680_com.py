import time
import datetime
import board
import adafruit_bme680
import pymongo

# Set up sensor connection using I2C
i2c = board.I2C() 
bme680 = adafruit_bme680.Adafruit_BME680_I2C(i2c, debug=False)

# Set up database connection


while True:

    # Read sensor data
    currentTemp = bme680.temperature
    currentGas = bme680.gas
    currentHumidity = bme680.relative_humidity
    currentPressure = bme680.pressure

    # Print data
    print("Temp: %0.1f C" % currentTemp)
    print("Gas: %d ohm" % currentGas)
    print("Humidity: %0.1f %%" % currentHumidity)
    print("Pressure: %0.3f hPa" % currentPressure)

    ## Write data to database
    mongodbclient = pymongo.MongoClient("mongodb://localhost:27017/")
    mongodb = mongodbclient["homedata"]
    dbcol = mongodb["sensor1"]
    dataSet = { "date": datetime.datetime.now, "gas": currentGas, "humidity": currentHumidity, "pressure": currentPressure, "temperature": currentTemp }
    x = dbcol.insert_one(dataSet)


    time.sleep(10)