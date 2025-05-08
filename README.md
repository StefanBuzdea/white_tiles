# 🎮 White Tile - Flutter Game App

**White Tile** is a fast-paced, interactive mobile game built with Flutter. The goal is simple: tap only the black tiles that fall from the top of the screen — with increasing speed. The game challenges the player's reflexes and accuracy in a clean and addictive format.

---

## 📱 Features

- ✅ Smooth gameplay with progressive speed
- 🎵 Sound effects: tap, game over, and streak
- ✨ Visual feedback every 10 black tiles hit (e.g. "Amazing!", "20 in a row!")
- 🧠 High score persistence using `SharedPreferences`
- 📤 Score sharing via system apps (Facebook, WhatsApp, etc.)
- 🎨 Clean, thematic UI (purple menu background, black game board)
- 🔁 Easy restart and quick navigation between screens

---

## 🧪 Screenshots

📍 *You can add screenshots of the main menu, gameplay, and game over screen here.*

---

## 🚀 How to Run the Project Locally

### 1. Clone the repository

```bash
git clone https://github.com/StefanBuzdea/white_tile.git
cd white_tile
```


### 2. Get dependencies

```bash
flutter pub get
```


### 3. Make sure a device or emulator is connected
 - Either connect a physical Android device (Developer Mode must be enabled)
or
 - Launch an Android emulator via Android Studio or AVD Manager


### 4. Run the app

```bash
flutter run
```

---

## 📁 Project Structure

```bash
lib/
├── main.dart               # App entry point
├── screens/              
    ├── game_screen.dart        # Game logic and UI
    ├── menu_screen.dart        # Main menu
    ├── game_over_screen.dart   # Game Over screen
assets/
└── sounds/                 # Audio files: tap.mp3, lose.mp3, wow.mp3
```

---

## 🛠️ Technologies Used

 - Flutter 3+

 - Dart

 - share_plus

 - shared_preferences

 - audioplayers

---

## 🧑‍💻 Author
Developed with passion by Buzdea Stefan

---

## 📜 License
This project is licensed under the MIT License – see the LICENSE file for details.