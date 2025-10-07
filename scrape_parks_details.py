import requests
from bs4 import BeautifulSoup
import json
import time

BASE = "https://www.floridastateparks.org"

def get_parks_list():
    parks = []
    for page in range(0, 13):  # pages 0–12
        url = f"{BASE}/parks-and-trails?page={page}"
        print(f"Fetching {url}")
        html = requests.get(url).text
        soup = BeautifulSoup(html, "html.parser")
        for link in soup.select("a.card__link"):
            name = link.get_text(strip=True)
            href = BASE + link["href"]
            parks.append({"name": name, "url": href})
    return parks

def scrape_park_details(park_url):
    html = requests.get(park_url).text
    soup = BeautifulSoup(html, "html.parser")

    def get_text(selector):
        el = soup.select_one(selector)
        return el.get_text(" ", strip=True) if el else ""

    # Narrative info
    headline = get_text("p.headline")
    body_paragraphs = [
        p.get_text(" ", strip=True)
        for p in soup.select(".park-description p")
        if "headline" not in (p.get("class") or [])
    ]

    # Structured info
    hours = get_text(".park-info__item--hours .park-info__text")
    fees = get_text(".park-info__item--fees .park-info__text")
    address = get_text(".park-info__item--pointer .address")
    maps_link = soup.select_one(".park-info__item--pointer .address-map-link")
    contact = get_text(".park-info__item--contact .park-info__text")

    # Experiences
    experiences = []
    exp_header = soup.find("h2", string="Experiences")
    if exp_header:
        for item in exp_header.find_next("div").select(".icon-item__title"):
            experiences.append(item.get_text(strip=True))

    # Amenities
    amenities = []
    amen_header = soup.find("h2", string="Amenities")
    if amen_header:
        for item in amen_header.find_next("div").select(".icon-item__title"):
            amenities.append(item.get_text(strip=True))

    return {
        "headline": headline,
        "description": " ".join(body_paragraphs),
        "hours": hours,
        "fees": fees,
        "address": address,
        "maps_link": maps_link["href"] if maps_link else "",
        "contact": contact,
        "experiences": experiences,
        "amenities": amenities,
    }

def main():
    parks = get_parks_list()
    all_data = []
    for park in parks:
        print(f"Scraping {park['name']}")
        try:
            details = scrape_park_details(park["url"])
            park.update(details)
            all_data.append(park)
            time.sleep(1)  # be polite to the server
        except Exception as e:
            print(f"❌ Failed {park['url']}: {e}")

    # Save raw data
    with open("parks_data_raw.json", "w", encoding="utf-8") as f:
        json.dump(all_data, f, indent=2, ensure_ascii=False)

    print("🎉 Scraping complete. Data saved to parks_data_raw.json")

if __name__ == "__main__":
    main()

