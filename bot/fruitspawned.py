import discord
from discord.ext import commands
import requests
import asyncio

# Replace with your Discord bot token
TOKEN = "MTMyNzYwOTE4ODc5MjI3MDg0OA.GlJdhN.KAxV-te7xpeLFHWADHBEDAqD75E7-0VuDWP9YI"

# Replace with the Blox Fruits game ID
GAME_ID = "2753915549"

# Replace with your webhook URL
with open("WEBHOOK.TXT", "r") as webhook_file:
    WEBHOOK_URL = webhook_file.read().strip()

# Configure intents
intents = discord.Intents.default()
intents.message_content = True  # Enables message content for commands
bot = commands.Bot(command_prefix="!", intents=intents)

# Function to send alerts to the webhook
def send_webhook_alert(fruit_name, spawn_location, server_id):
    embed = {
        "title": "🍎 Fruit Spawn Alert!",
        "color": 16776960,  # Yellow
        "fields": [
            {"name": "Fruit Name", "value": fruit_name, "inline": True},
            {"name": "Location", "value": spawn_location, "inline": True},
            {"name": "Server ID", "value": server_id, "inline": False},
        ],
    }
    payload = {"embeds": [embed]}
    try:
        response = requests.post(WEBHOOK_URL, json=payload)
        if response.status_code == 204:
            print("Webhook alert sent successfully!")
        else:
            print(f"Failed to send webhook alert: {response.status_code} {response.text}")
    except Exception as e:
        print(f"Error sending webhook: {e}")

@bot.event
async def on_ready():
    print(f"Bot is online as {bot.user}")
    asyncio.create_task(periodic_fruit_scans())  # Start periodic server scans

@bot.event
async def on_message(message):
    # Debug: Log incoming messages
    print(f"Message from {message.author}: {message.content} (in {message.guild})")
    
    # Ignore messages from the bot itself
    if message.author == bot.user:
        return

    # Process commands
    await bot.process_commands(message)

@bot.command()
async def servers(ctx):
    await ctx.send("Scanning servers for fruit spawns...")
    url = f"https://games.roblox.com/v1/games/{GAME_ID}/servers/Public"
    response = requests.get(url)
    if response.status_code == 200:
        servers = response.json().get("data", [])
        for server in servers:
            if "fruit_spawn" in server and server["fruit_spawn"]:
                fruit_name = server["fruit_spawn"]["name"]
                spawn_location = server["fruit_spawn"]["location"]
                server_id = server["id"]

                # Send a webhook alert
                send_webhook_alert(fruit_name, spawn_location, server_id)

                # Send a message in Discord
                await ctx.send(f"🍎 **Fruit Spawned!**\n**Name**: {fruit_name}\n**Location**: {spawn_location}\n**Server ID**: {server_id}")
    else:
        await ctx.send("Failed to fetch server data.")

async def periodic_fruit_scans():
    while True:
        url = f"https://games.roblox.com/v1/games/{GAME_ID}/servers/Public"
        response = requests.get(url)
        if response.status_code == 200:
            servers = response.json().get("data", [])
            for server in servers:
                if "fruit_spawn" in server and server["fruit_spawn"]:
                    fruit_name = server["fruit_spawn"]["name"]
                    spawn_location = server["fruit_spawn"]["location"]
                    server_id = server["id"]

                    # Send a webhook alert
                    send_webhook_alert(fruit_name, spawn_location, server_id)
        await asyncio.sleep(600)  # Scan every 10 minutes

bot.run(TOKEN)
