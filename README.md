# Solar - Your Easy Device Connection App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![PocketBase](https://img.shields.io/badge/PocketBase-333333?style=for-the-badge&logo=pocketbase&logoColor=white)](https://pocketbase.io/)

**Connect with me:** [My Website](https://rishavwiki.netlify.app/)

## Demo Video


https://github.com/user-attachments/assets/68be390e-85c4-4693-bfb1-e10ac8fe1803




## What is Solar?

Imagine you have a bunch of smart devices at home or in your office. "Solar" is a mobile app that makes it super easy to connect to them! Instead of typing in complicated codes or searching through menus, you can simply scan a QR code with your phone's camera, and *voila*! You're connected.

Solar is like a friendly helper that simplifies the process of linking your phone to other devices. It's built to work on both Android and iPhone devices.

## What Can Solar Do?

Here's what makes Solar special:

-   **QR Code Magic:** Connect to devices instantly by scanning their QR codes with your phone's camera. It's as easy as taking a picture!
-   **Manual Connection Option:** If a device doesn't have a QR code, or if the scan isn't working, no problem! You can connect manually.
-   **Flashlight Feature:** Scanning in the dark? No worries! Solar lets you turn on your phone's flashlight while scanning QR codes.
-   **Copy and Paste:** Need to use the QR code information somewhere else? Solar lets you copy the scanned data to your phone's clipboard.
-   **Looks Good, Feels Good:** Choose between a light or dark theme for the app, depending on your preference.
-   **Speaks Your Language:** Solar can be used in multiple languages, making it accessible to everyone.
-   **Secure Connection:** Solar has a basic security check to make sure you're connecting to the right place.
-   **Welcoming Screen:** When you open the app, you'll see a nice splash screen while it gets ready.
- **Works on Most Phones:** Solar is designed to work on Android and iOS devices.

## How Does Solar Work?

Solar uses a few clever technologies behind the scenes to make everything work smoothly:

-   **Flutter:** This is the tool we used to build the app. It lets us create a beautiful and responsive app that works on both Android and iPhone.
-   **PocketBase:** This is like a digital filing cabinet that helps Solar store and manage information.
-   **GetX:** This is a helper that makes the app run smoothly and efficiently.
-   **Mobile Scanner:** This is the tool that lets Solar scan QR codes.
- **Permission Handler:** This is the tool that lets Solar ask for permission to use the camera.
- **Flutter Dotenv:** This is the tool that lets Solar use the .env file.
- **SQFlite Common FFI:** This is the tool that lets Solar use SQLite on desktop platforms.

## How to Get Started

Here's how you can get Solar up and running:

### What You Need

1.  **A Phone:** You'll need an Android or iPhone to use Solar.
2.  **Flutter:** This is the tool we used to build the app. If you want to modify the app, you'll need to install it on your computer. You can find instructions here: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
3.  **PocketBase:** This is the digital filing cabinet that Solar uses. If you want to modify the app, you'll need to set up a PocketBase instance.

### Steps to Install

1.  **Get the Code:** Download the Solar code from the repository.
    ```bash
    git clone <repository_url>
    cd login
    ```
2.  **Install the Helpers:** Open your terminal or command prompt, go to the Solar folder, and type:
    ```bash
    flutter pub get
    ```
    This command downloads all the necessary helper tools.
3.  **Set Up the Filing Cabinet:**
    -   Create a file named `.env` in the main Solar folder.
    -   Inside this file, add the address of your PocketBase instance, like this:
        ```
        POCKETBASE_URL=https://your-pocketbase-url.com
        ```
        Replace `https://your-pocketbase-url.com` with the actual address.
4.  **Camera Permission:**
    -   Make sure to add the camera permission to the `AndroidManifest.xml` (for Android) and `Info.plist` (for iOS) files. This allows the app to use your phone's camera for scanning.

### Run the App

1.  **Connect Your Phone:** Connect your Android or iPhone to your computer, or start an emulator.
2.  **Start Solar:** In your terminal or command prompt, type:
    ```bash
    flutter run
    ```
    This will launch the Solar app on your phone or emulator.

## What's Under the Hood? (For the Curious)

If you're interested in the technical details, here's a peek at how Solar is organized:

-   **`main.dart`:** This is the heart of the app. It sets everything up, including the connection to PocketBase, the theme, and the language.
-   **`local_access.dart`:** This is where the QR code scanning magic happens. It handles the camera, detects QR codes, and shows you the scanned data.
- **`QrScannerOverlayShape`:** This is the shape that appears on the screen when you are scanning a QR code.
-   **Theme Management:** Solar lets you switch between light and dark themes. It remembers your choice so you don't have to set it every time.
-   **Language Support:** Solar can be used in different languages. You can choose your preferred language in the app settings.
-   **Security Check:** Solar has a basic security check to make sure you're connecting to the right place.
-   **Splash Screen:** When you open the app, you'll see a nice splash screen while it gets ready.

## What's Next for Solar?

We're always working to make Solar even better! Here are some things we're planning to add:

-   **Full Login System:** We'll add a complete login system so you can create an account and keep your settings safe.
-   **Data Sync:** We'll make it so your data is automatically backed up and synced.
-   **More Features:** We'll add more features to help you manage and control your devices.
-   **Better Design:** We'll keep improving the look and feel of the app.
-   **Fewer Errors:** We'll work hard to make the app more stable and reliable.
- **Testing:** We will add tests to make sure the app is working correctly.

## Want to Help?

If you're interested in helping us improve Solar, we'd love to have you! Feel free to share your ideas or contribute to the project.

## License

Solar is open-source and licensed under the MIT License.

