# PM & DST

A tiny Apple Watch app that answers two questions at a glance: **is it AM or PM?** and **is Daylight Saving Time on?**

It adds two retro, Casio‑style watch face complications, plus a simple companion app with a live clock.

<p align="center">
  <img src="PM%20%26%20DST%20Watch%20App/Assets.xcassets/AppIcon.appiconset/PM%20%40%20DST%20(1).png" alt="PM & DST app icon" width="160">
</p>

## Features

### Complications

| Complication | What it shows | Watch face slots |
|---|---|---|
| **AM / PM** | `AM` or `PM` for your current local time | Circular, Rectangular, Inline |
| **DST Status** | `DST` while Daylight Saving Time is active; blank during standard time | Circular, Rectangular, Inline |

- Bold, monospaced type for a vintage digital‑watch look.
- Refreshes exactly on the hour, with a 72‑hour schedule queued ahead, so the display flips at the right moment with minimal battery use.
- Uses the watch's automatically updating time zone, so it stays correct when you travel or when DST starts or ends.
- Text scales down to fit smaller watch face slots.

### Watch app

- A live clock that ticks every second, in green monospaced digits.
- A **Daylight Saving: ON / OFF** indicator underneath: green when on, gray when off.

## Project structure

```
PM & DST Watch App/     The watchOS app (live clock + DST indicator)
  ContentView.swift
  PM___DSTApp.swift
  Assets.xcassets/      App icon and accent color
WatchWidgets/           WidgetKit extension with the two complications
  WatchWidgets.swift    Timeline provider, AM/PM widget, DST widget, widget bundle
  Info.plist
PM & DST.xcodeproj/     Xcode project and shared schemes
```

## Requirements

- Xcode with the watchOS 26 SDK or later
- Watch app: watchOS 27.0+
- Widget extension: watchOS 26.4+
- Built with SwiftUI and WidgetKit. No third‑party dependencies.

## Build & run

1. Clone the repo and open `PM & DST.xcodeproj` in Xcode.
2. Under **Signing & Capabilities**, set your own development team for both targets (and change the bundle identifiers if needed).
3. Pick the **PM & DST Watch App** scheme and run it on a paired Apple Watch or the watchOS Simulator.
4. On the watch, edit a watch face, tap a complication slot, and choose **AM / PM** or **DST Status** under PM & DST.

To try the complications on their own, run the **WatchWidgetsExtension** scheme.

## Privacy

PM & DST has no accounts, ads, analytics or network code, and asks for no permissions. It only reads the watch's own clock and time zone. For the App Store privacy label, this app is **Data Not Collected**.

## Author

Created by Senalbert Rodriguez.

## License

PM & DST is free and open source under the [MIT License](LICENSE). You're welcome to use it, learn from it, change it and share it. Just keep the copyright notice.
