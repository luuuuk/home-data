import time
import datetime
import board
import adafruit_bme680
import pymongo

# Set up sensor connection using I2C
i2c = board.I2C() 
bme680 = adafruit_bme680.Adafruit_BME680_I2C(i2c, debug=False)

# start_time and curr_time ensure that the
# burn_in_time (in seconds) is kept track of.

start_time = time.time()
curr_time = time.time()
burn_in_time = 300

burn_in_data = []

try:

    # Collect gas resistance burn-in values, then use the average
    # of the last 50 values to set the upper limit for calculating
    # gas_baseline.
    print('Collecting gas resistance burn-in data for 5 mins\n')
    while curr_time - start_time < burn_in_time:
        curr_time = time.time()
        gas = bme680.gas
        burn_in_data.append(gas)
        print('Gas: {0} Ohms'.format(gas))
        time.sleep(1)

    gas_baseline = sum(burn_in_data[-50:]) / 50.0

    # Set the humidity baseline to 40%, an optimal indoor humidity.
    hum_baseline = 40.0

    # This sets the balance between humidity and gas reading in the
    # calculation of air_quality_score (25:75, humidity:gas)
    hum_weighting = 0.25

    print('Gas baseline: {0} Ohms, humidity baseline: {1:.2f} %RH\n'.format(
        gas_baseline,
        hum_baseline))
        
    while True:

        # Read sensor data
        currentTemp = bme680.temperature

        currentGas = bme680.gas
        gas_offset = gas_baseline - currentGas

        currentHumidity = bme680.relative_humidity
        hum_offset = currentHumidity - hum_baseline

        currentPressure = bme680.pressure

        timestamp = datetime.datetime.now()

        # Calculate hum_score as the distance from the hum_baseline.
        if hum_offset > 0:
            hum_score = (100 - hum_baseline - hum_offset)
            hum_score /= (100 - hum_baseline)
            hum_score *= (hum_weighting * 100)
        else:
            hum_score = (hum_baseline + hum_offset)
            hum_score /= hum_baseline
            hum_score *= (hum_weighting * 100)

        # Calculate gas_score as the distance from the gas_baseline.
        if gas_offset > 0:
            gas_score = (gas / gas_baseline)
            gas_score *= (100 - (hum_weighting * 100))
        else:
            gas_score = 100 - (hum_weighting * 100)

        # Calculate air_quality_score.
        air_quality_score = hum_score + gas_score

        # print('Gas: {0:.2f} Ohms,humidity: {1:.2f} %RH,air quality: {2:.2f}'.format(
        #     currentGas,
        #     currentHumidity,
        #     air_quality_score))

        # Print data
        print("\nTimestamp: " + timestamp.strftime('%A %d-%m-%Y, %H:%M:%S'))
        print("Temp: %0.1f C" % currentTemp)
        print("Gas: %d ohm" % currentGas)
        print("Humidity: %0.1f %%RH" % currentHumidity)
        print("Pressure: %0.3f hPa" % currentPressure)
        print('air quality: %0.2f' % air_quality_score)

        # Write data to database
        # mongodbclient = pymongo.MongoClient("mongodb://localhost:27017/")
        # mongodb = mongodbclient["homedata"]
        # dbcol = mongodb["sensors"]
        # dataSet = { "date": timestamp, "gas": currentGas, "humidity": currentHumidity, "pressure": currentPressure, "temperature": currentTemp }
        # x = dbcol.insert_one(dataSet)


        time.sleep(60)

except KeyboardInterrupt:
    pass