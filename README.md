# 🌴 Florida State Parks App

A Flutter mobile application that helps users explore Florida State Parks.  
Features include:
- Interactive **Google Map** with park markers
- Detailed park pages with descriptions, hours, fees, amenities, and activities
- Integration with concessionaire services (future roadmap: booking horseback rides, kayak rentals, glamping, etc.)
- Clean, structured park data sourced from [Florida State Parks](https://www.floridastateparks.org/parks-and-trails)

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- Xcode (for iOS) or Android Studio (for Android)
- A valid Google Maps API key

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/florida_state_parks.git
   cd florida_state_parks

   INSTALL DEPENDENCIES
   flutter pub get

ADD GOOGLE MAPS API KEYS

RUN THE APP
flutter run


PROJECT STRUCTURE
lib/
  main.dart              # App entry point
  pages/
    parks_map_page.dart  # Interactive map with markers
    park_detail_page.dart# Park detail view
assets/
  parks_data.json        # Cleaned park data (addresses, amenities, etc.)
  parks_data_with_coords.json # Park data with lat/lng for map markers

🔮 Roadmap
✅ Interactive map with markers

✅ Park detail pages

⏳ Shop tab (affiliate products, outdoor gear, guides)

⏳ Concessionaire booking integration (P3 horseback rides, kayak rentals, glamping)

⏳ User location + nearby parks

⏳ Marker clustering and filters (e.g., camping, hiking, equestrian)
