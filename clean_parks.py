import json
import re

with open("assets/parks_data_raw.json", "r", encoding="utf-8") as f:
    parks = json.load(f)

cleaned = []
for park in parks:
    raw_name = park.get("name", "").strip()
    headline = park.get("headline", "").strip()
    description = park.get("description", "").strip()

    name = ""
    remainder = ""

    # Try to extract up to "State Park" or "State Trail"
    name_match = re.search(r'^(.*?(State Park|State Trail))', raw_name)
    if name_match:
        name = name_match.group(1).strip()
        remainder = raw_name[name_match.end():].strip()
    else:
        # Otherwise, split before the first digit (address)
        parts = re.split(r'(\d.*)', raw_name, 1)
        if len(parts) == 3:
            name_candidate = parts[0].strip()
            remainder = parts[0][len(name_candidate):] + parts[1]
            # Try to split name_candidate into name + description
            # Look for first lowercase sentence start
            split_match = re.search(r'([A-Z][^a-z]*[a-z]+(?:\s+[A-Z][^a-z]*[a-z]+)*)', name_candidate)
            if split_match:
                name = split_match.group(1).strip()
                remainder = name_candidate[len(name):].strip()
            else:
                name = name_candidate
        else:
            # fallback: first 8 words
            words = raw_name.split()
            name = " ".join(words[:8])
            remainder = " ".join(words[8:])

    # --- DESCRIPTION CLEANUP ---
    if not description:
        # Remove any address-looking part (starting with a digit)
        desc_candidate = re.split(r'\d', remainder, 1)[0].strip()
        if desc_candidate:
            description = desc_candidate
        elif headline:
            description = headline

    cleaned.append({
        "name": name,
        "url": park.get("url", ""),
        "headline": headline,
        "description": description,
        "hours": park.get("hours", ""),
        "fees": park.get("fees", ""),
        "address": park.get("address", ""),
        "maps_link": park.get("maps_link", ""),
        "contact": park.get("contact", ""),
        "experiences": park.get("experiences", []),
        "amenities": park.get("amenities", []),
    })

with open("assets/parks_data.json", "w", encoding="utf-8") as f:
    json.dump(cleaned, f, indent=2, ensure_ascii=False)

print("🎉 Cleaned data saved to parks_data.json")
