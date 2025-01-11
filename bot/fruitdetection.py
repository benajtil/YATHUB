import requests
import time

# Roblox API and Game Configuration
GAME_ID = "2753915549"  # Blox Fruits Game ID
ROBLOX_API_URL = f"https://games.roblox.com/v1/games/{GAME_ID}/servers/Public"

# Discord Webhook Configuration
# Load webhook URL from file
with open("WEBHOOK.TXT", "r") as webhook_file:
    WEBHOOK_URL = webhook_file.read().strip()


def detect_fruits():
    """
    Scans all public servers for the given Roblox game and detects fruit spawns.
    Logs or sends data via a webhook if a fruit is found.
    """
    cursor = None  # Cursor for pagination
    while True:
        # Fetch server data from Roblox API
        params = {"cursor": cursor} if cursor else {}
        response = requests.get(ROBLOX_API_URL, params=params)

        if response.status_code == 200:
            data = response.json()
            servers = data.get("data", [])

            # If no servers are returned, stop scanning
            if not servers:
                print("No more servers to scan.")
                break

            for server in servers:
                # Extract server information
                server_id = server.get("id", "Unknown")
                players = server.get("playing", 0)
                max_players = server.get("maxPlayers", 0)
                ping = server.get("ping", "Unknown")

                # Hypothetical logic to check if a fruit is spawned
                fruit_spawned, fruit_name = check_fruit_spawn(server_id)

                # Log server details
                print(f"Server ID: {server_id}")
                print(f"Players: {players}/{max_players}")
                print(f"Ping: {ping}")
                if fruit_spawned:
                    print(f"Fruit Spawned: {fruit_name}")
                print("-" * 40)

                    # Send the data to Discord webhook
                send_webhook_message(server_id, players, max_players, ping, fruit_spawned, fruit_name)

            # Get the next cursor for pagination
            cursor = data.get("nextPageCursor")
            if not cursor:
                print("Finished scanning all servers.")
                break
        else:
            print(f"Failed to fetch server data. HTTP Status: {response.status_code}")
            break

        time.sleep(1)  # Avoid spamming the API


def check_fruit_spawn(server_id):
    """
    Hypothetical function to check if a fruit has spawned in the given server.
    Returns:
        (bool, str): Tuple indicating if a fruit is spawned and the fruit's name.
    """
    # Replace this with your actual fruit detection logic
    # For example, calling an in-game script or API
    # Here, it's a placeholder returning False and None
    # Example: Call an endpoint or use an external method
    fruit_spawned = False
    fruit_name = None

    # Example placeholder: Assume the server ID determines fruit spawns
    if int(server_id[-1]) % 2 == 0:  # Example condition
        fruit_spawned = True
        fruit_name = "Dragon Fruit"

    return fruit_spawned, fruit_name


def send_webhook_message(server_id, players, max_players, ping, fruit_spawned, fruit_name):
    """
    Sends a message to the configured Discord webhook with server details.
    """
    if not WEBHOOK_URL:
        return  # Skip sending webhook if URL is not configured

    fields = [
        {"name": "Server ID", "value": server_id, "inline": True},
        {"name": "Players", "value": f"{players}/{max_players}", "inline": True},
        {"name": "Ping", "value": str(ping), "inline": True},
    ]

    # Add fruit details if a fruit is spawned
    if fruit_spawned:
        fields.append({"name": "Fruit Spawned", "value": fruit_name, "inline": False})

    payload = {
        "content": "",
        "embeds": [{
            "title": "Fruit Detected!",
            "color": 3447003,  # Blue
            "fields": fields,
        }]
    }

    try:
        response = requests.post(WEBHOOK_URL, json=payload)
        if response.status_code == 204:
            print("Webhook sent successfully!")
        else:
            print(f"Failed to send webhook: {response.status_code} {response.text}")
    except Exception as e:
        print(f"Error sending webhook: {e}")
