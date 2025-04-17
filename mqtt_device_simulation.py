import paho.mqtt.client as mqtt
import time
import json

# Replace with ThingsBoard server's public IP or domain
THINGSBOARD_HOST = "3.94.198.187"
# Replace with device's access token
ACCESS_TOKEN = "hsTurYnDomH7SvQARUuD"

# MQTT topic for telemetry data
TOPIC = "v1/devices/me/telemetry"

# Telemetry data to send
def get_telemetry_data():
    return {
        "temperature": 25.0 + (5 * time.time() % 10),  # Simulate fluctuating temperature
        "humidity": 60 + (5 * time.time() % 10)      # Simulate fluctuating humidity
    }

# Callback for successful connection
def on_connect(client, userdata, flags, rc):
    print(f"Connected to ThingsBoard with result code {rc}")

# Initialize MQTT client
client = mqtt.Client()
client.username_pw_set(ACCESS_TOKEN)
client.on_connect = on_connect

client.connect(THINGSBOARD_HOST, 1883, 60)

try:
    while True:
        telemetry_data = get_telemetry_data()
        # Publish telemetry data to ThingsBoard
        client.publish(TOPIC, json.dumps(telemetry_data))
        print(f"Telemetry sent: {telemetry_data}")
        time.sleep(5)  # Send data every 5 seconds
except KeyboardInterrupt:
    print("Simulation stopped.")
finally:
    client.disconnect()