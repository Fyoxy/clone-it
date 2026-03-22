# Clone IT!

A VR puzzle game built for the **7 Day Godot XR Game Jam — March 2026** [Gamejam](https://itch.io/jam/godot-xr-game-jam-mar-2026)

## About

Clone IT! is a time-bending VR puzzle game where you use a bracelet on your wrist to **REWIND** back to the start of a level — leaving behind a clone that replays your previous actions. By coordinating with your past selves, you'll solve increasingly complex puzzles across all seven levels.

Stand on pressure plates, open doors, move platforms — then rewind and let your clone handle the job while you tackle the next piece of the puzzle.

## How to Play

- Use the **bracelet on your hand** to rewind time
- Watch your **clone repeat your exact movements** from the previous loop
- Stack multiple clones to solve multi-step puzzles
- Complete all **7 levels**

## Built With

- [Godot Engine](https://godotengine.org/) (4.6+) with OpenXR
- [Godot XR Tools](https://godotengine.org/asset-library/asset/1515)
- [OpenXR Vendors](https://github.com/GodotVR/godot_openxr_vendors)
- Built on top of the [Godot XR Template](https://github.com/GodotVR/godot-xr-template)

## Project Structure

| Directory | Contents |
|-----------|----------|
| `game/` | Level scenes and game logic |
| `components/` | Reusable game components (clone system, rewind mechanics, etc.) |
| `assets/` | Textures, models, and audio |
| `addons/` | Godot XR Tools and other plugins |
| `build/` | Build and export configuration |

## Known Issues

- **WebXR**: Controls do not currently work in the WebXR export. Native headset builds are recommended.

## Getting Started

1. Clone the repository
2. Open the project in **Godot 4.6+**
3. Connect your VR headset and hit Play — or export to Android for standalone headsets

## Credits

### Sound Effects
- **Sonniss** — [#GameAudioGDC Bundle](https://sonniss.com/) (Volumes 1–9)
  - CREAMisc_Creature Power On 14 — DDUMAIS / MCSFX
  - Bluezone_BC0304 — Retrofuturistic Computer Button 013
  - Bluezone_BC0300 — Alien Interface Sci-Fi Texture 046
  - ROBTVox_Android Talking Wah Goofy 01 — BOLT / ARP2600
- **AstroMenace SFX** — Plasma Hit, Drag Error

### Materials
- [AmbientCG](https://ambientcg.com/) — PBR textures (CC0)

### Icons
- Board Game Icons (1.1) Created by Kenney (www.kenney.nl)

### Music
- *Jazzy Ambient Piano (Mansion)* by **Hakren** — [freesound.org/s/414557](https://freesound.org/s/414557/) (CC0)
- *Ambient Piano Loop 3_3* by **Erokia** — [freesound.org/s/477125](https://freesound.org/s/477125/) (CC BY-NC 4.0)
- *Ambient Piano Loop 21_2* by **Erokia** — [freesound.org/s/483452](https://freesound.org/s/483452/) (CC BY-NC 4.0)
- *Ambient Piano Loop 4* by **Erokia** — [freesound.org/s/477124](https://freesound.org/s/477124/) (CC BY-NC 4.0)

## License

This project is licensed under the [MIT License](LICENSE).
