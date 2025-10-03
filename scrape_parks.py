import requests
from bs4 import BeautifulSoup
import json

parks = []

# Loop through all 12 pages
for page in range(0, 13):
    url = f"https://www.floridastateparks.org/parks-and-trails?page={page}"
    r = requests.get(url)
    soup = BeautifulSoup(r.text, "html.parser")

    for h3 in soup.find_all("h3", class_="card__title"):
        name = h3.get_text(strip=True)
        link = h3.find("a")["href"] if h3.find("a") else None
        parks.append({
            "name": name,
            "url": f"https://www.floridastateparks.org{link}" if link else None
        })

# Save to JSON
with open("florida_parks.json", "w") as f:
    json.dump(parks, f, indent=2)

print(f"Scraped {len(parks)} parks")
# This script scrapes the names and URLs of Florida state parks from the official website
# and saves the data into a JSON file named 'florida_parks.json'.