 # 🐝 BioBuzz Scorekeeper


> An open-source, cross-platform scoring and training application designed for the FIRST Tech Challenge (FTC) BioBuzz season. 


This application provides teams with a reliable way to calculate scores, simulate matches, and practice driver skills under real match conditions with audio feedback. 


## ✨ Features


*   **⏱️ Solo Training Timer:** A fully integrated match simulator featuring official FTC timings (30s Autonomous, 8s Transition, 120s TeleOp).

*   **🔒 Dynamic State Locking:** The UI intelligently locks and unlocks scoring elements based on the active match phase (e.g., *Endgame* elements are only accessible in the last 60 seconds).

*   **🔊 Audio Feedback:** Integrated match sounds and buzzers perfectly synchronized with phase transitions.

*   **📱 Responsive & Cross-Platform:** Fluid UI adapted for both vertical mobile screens (Android/iOS) and horizontal desktop monitors (Windows).

*   **⚡ High Performance:** Built with clean architecture and **Riverpod** for robust, zero-lag state management.

*   **🤖 CI/CD Automation:** Automated workflows via GitHub Actions generate ready-to-install `.apk` and `.exe` files on every release.


## 📥 Downloads & Installation


You don't need to build the project from source to use it. Automated builds are generated via GitHub Actions.


1. Navigate to the [Actions](../../actions) tab or the **Releases** section on GitHub.

2. Download the artifact that matches your platform:

   *   **Android:** Download the `.apk` file and install it directly on your device.

   *   **Windows:** Download the `Scorekeeper_BioBuzz_Setup.exe` installer for a standard desktop installation.


## 🛠️ Tech Stack


*   **Framework:** [Flutter](https://flutter.dev/) (Dart)

*   **State Management:** [flutter_riverpod](https://riverpod.dev/)

*   **Audio Engine:** `audioplayers`

*   **CI/CD:** GitHub Actions & Inno Setup (for Windows installers)


## 🚀 Building from Source


If you want to clone the repository and run the app locally:


1. Ensure you have Flutter installed on your machine.

2. Clone the repository:

   ```bash

   git clone [https://github.com/RobertFlorin15/biobuzz-scorekeeper.git](https://github.com/RobertFlorin15/biobuzz-scorekeeper.git)

3. flutter pub get

4. flutter run (Note: Linux users may need to install GStreamer dependencies for the audio player to compile correctly).


## 🏆 Built By


Developed with ❤️ by Robert | 19061am 17962m 19075m 30324m for the FIRST Tech Challenge community. 

> Disclaimer: This is an unofficial, community-created application. It is not affiliated with, sponsored by, or endorsed by FIRST (For Inspiration and Recognition of Science and Technology) or RTX. The BioBuzz name and logos are trademarks of FIRST.
