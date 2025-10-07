import json
import requests
import time

API_KEY = "dc5b7c541b5140bc9547860426d5bbca"  # OpenCage (free tier)
GEOCODE_URL = "https://api.opencagedata.com/geocode/v1/json"

with open("assets/parks_data.json", "r", encoding="utf-8") as f:
    parks = json.load(f)

for park in parks:
    if "lat" in park and "lng" in park:
        continue  # already geocoded

    address = park.get("address", "").strip()
    if not address:
        continue

    params = {
        "q": address,
        "key": API_KEY,
        "limit": 1
    }

    try:
        res = requests.get(GEOCODE_URL, params=params)
        data = res.json()
        if data["results"]:
            coords = data["results"][0]["geometry"]
            park["lat"] = coords["lat"]
            park["lng"] = coords["lng"]
            print(f"✅ {park['name']}: {coords['lat']}, {coords['lng']}")
        else:
            print(f"❌ No result for {park['name']}")
    except Exception as e:
        print(f"❌ Error for {park['name']}: {e}")

    time.sleep(1)  # Be polite to the API

with open("assets/parks_data_with_coords.json", "w", encoding="utf-8") as f:
    json.dump(parks, f, indent=2, ensure_ascii=False)

print("🎯 parks_data_with_coords.json created with lat/lng")
