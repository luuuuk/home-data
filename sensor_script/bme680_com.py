from http import server
import time
import datetime
import board
import adafruit_bme680
import requests
from dotenv import dotenv_values



# load config from .env
config = dotenv_values(".env")

# Set up sensor connection using I2C
i2c = board.I2C() 
bme680 = adafruit_bme680.Adafruit_BME680_I2C(i2c, debug=False)

# start time and current time ensure that the
# burn-in-time (in seconds) is kept track of.

startTime = time.time()
currTime = time.time()
burnInTime = 300
gas = 0
gasBaseline = 0.0
humBaseline = 0.0
humWeighting = 0.0
serverSession = requests.Session()

burnInData = []


def initialise():
    """Initialises the sensor by performing a burn-in for 5 minutes and authenticates on the 
    server, starts a session."""

    print('initialise()')
    # Collect gas resistance burn-in values, then use the average
    # of the last 50 values to set the upper limit for calculating
    # gas_baseline.
    print('Collecting gas resistance burn-in data for 5 mins\n')
    while currTime - startTime < burnInTime:
        currTime = time.time()
        gas = bme680.gas
        burnInData.append(gas)
        print('Gas: {0} Ohms'.format(gas))
        time.sleep(1)

    gasBaseline = sum(burnInData[-50:]) / 50.0

    # Set the humidity baseline to 40%, an optimal indoor humidity.
    humBaseline = 40.0

    # This sets the balance between humidity and gas reading in the
    # calculation of air_quality_score (25:75, humidity:gas)
    humWeighting = 0.25

    print('Gas baseline: {0} Ohms, humidity baseline: {1:.2f} %RH\n'.format(
        gasBaseline,
        humBaseline))

    login()


def login():
    """Logs into the server using the given credentials and starts a session."""
    # Log in with username and password
    authData = {'email': config['EMAIL'], 'password': config['PWD']}
    response = serverSession.post(config['SERVER_URL'] + '/auth/login', authData)
    responseJSON = response.json()

    if(responseJSON['message'] == 'logged in'):
        print('Logged in, session is active')


def readData():
    """Reads data from the sensor and computes the humidity as well as the gas and air quality 
    score according to the baselines set during initialisation."""

    print('readData()')
    # Read sensor data
    currentTemp = bme680.temperature

    currentGas = bme680.gas
    gasOffset = gasBaseline - currentGas

    currentHumidity = bme680.relativeHumidity
    humOffset = currentHumidity - humBaseline

    currentPressure = bme680.pressure

    timestamp = datetime.datetime.now()

    # Calculate hum_score as the distance from the hum_baseline.
    if humOffset > 0:
        humScore = (100 - humBaseline - humOffset)
        humScore /= (100 - humBaseline)
        humScore *= (humWeighting * 100)
    else:
        humScore = (humBaseline + humOffset)
        humScore /= humBaseline
        humScore *= (humWeighting * 100)

    # Calculate gas_score as the distance from the gas_baseline.
    if gasOffset > 0:
        gasScore = (gas / gasBaseline)
        gasScore *= (100 - (humWeighting * 100))
    else:
        gasScore = 100 - (humWeighting * 100)

    # Calculate air quality score
    airQualityScore = humScore + gasScore

    # Print data
    print("\nTimestamp: " + timestamp.strftime('%A %d-%m-%Y, %H:%M:%S'))
    print("Temp: %0.1f C" % currentTemp)
    print("Gas: %d ohm" % currentGas)
    print("Humidity: %0.1f %%RH" % currentHumidity)
    print("Pressure: %0.3f hPa" % currentPressure)
    print('air quality: %0.2f' % airQualityScore)

    return timestamp, currentTemp, currentGas, currentHumidity, currentPressure, airQualityScore


def sendToServer(timestamp, temp, gas, hum, press, air):
    """Checks that session is still active, renews session if expired and sends data to API endpoint."""

    print('sendToServer()')

    # check if active session
    healthcheck = serverSession.get(config['SERVER_URL'] + '/auth/healthcheck')
    healthcheckJSON = healthcheck.json()

    # renew session if expired
    if(healthcheckJSON['message'] != 'authenticated'):

        print('Session expired. Logging in again.')
        login()

    # send data to server
    sensorData = {
        'timestamp':  timestamp, 
        'temperature': temp,
        'gas': gas,
        'humidity': hum,
        'pressure': press,
        'airqualiry': air,
        'sensorid': config['SENSORID']
        }
    response = serverSession.post(config['SERVER_URL'] + '/api/datapoint/create', sensorData)
    responseJSON = response.json()

    # renew session if expired
    if(responseJSON['message'] != 'success'):
        print('Failed creating a new datapoint.')

    else:
        print('New data point successfully created on the server.')


if __name__ == "__main__":
    print('Running bme680 script.')

    try:

        initialise()

        while True:

            timestamp, currentTemp, currentGas, currentHumidity, currentPressure, airQualityScore = readData()

            sendToServer(timestamp, currentTemp, currentGas, currentHumidity, currentPressure, airQualityScore)

            time.sleep(600)

    except KeyboardInterrupt:
        pass
