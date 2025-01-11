import discord
from discord.ext import commands, tasks
import asyncio
from bot.fruitdetection import detect_fruits  # Import after renaming 'bot' to 'modules'

# Load Discord bot token
with open("TOKEN.TXT", "r") as token_file:
    TOKEN = token_file.read().strip()

# Configure Discord bot
intents = discord.Intents.default()
intents.message_content = True
bot = commands.Bot(command_prefix="!", intents=intents)


@bot.event
async def on_ready():
    print(f"Bot is online as {bot.user}")
    if not auto_detect.is_running():
        auto_detect.start()  # Start the periodic task


@tasks.loop(seconds=30)
async def auto_detect():
    print("Running fruit detection...")
    await asyncio.to_thread(detect_fruits)
    print("Fruit detection completed.")


# Run the bot
bot.run(TOKEN)
