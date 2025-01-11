from flask import Flask, render_template
import requests

app = Flask(__name__, template_folder="templates")

GAME_ID = "2753915549"  # Replace with the Blox Fruits game ID


@app.route("/")
def dashboard():
    url = f"https://games.roblox.com/v1/games/{GAME_ID}/servers/Public"
    response = requests.get(url)
    servers = []
    if response.status_code == 200:
        servers = response.json()["data"]
    return render_template("dashboard.html", servers=servers)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
