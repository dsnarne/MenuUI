# IntroSwiftApp

An iOS application built with SwiftUI featuring three projects: Recipe Book, Expense Tracker, and Photo Gallery.

## Features

### Recipe Book
- Browse and search recipes with category filtering
- View detailed recipes with ingredients and step-by-step instructions
- Add custom recipes
- Sample recipes included

### Expense Tracker
- Track expenses by category
- Filter by time period (Today, Week, Month, All Time)
- Add, edit, and delete expenses
- Persistent storage using UserDefaults
- Summary card with total expenses
- Search functionality

### Photo Gallery
- Grid layout with adjustable columns (1, 2, or 3)
- Full-screen photo detail view
- Pinch to zoom and drag to pan gestures
- Search photos by name or description
- 12 sample photos included

### Counter App
- Simple counter demonstrating basic SwiftUI state management

## Project Structure

```
IntroSwiftApp/
├── IntroSwiftAppApp.swift          # App entry point
├── MainMenuView.swift              # Main navigation menu
├── ContentView.swift               # Counter app
├── RecipeBook/                     # Recipe management
├── ExpenseTracker/                 # Expense tracking
└── PhotoGallery/                   # Photo gallery
```

## Getting Started

### Prerequisites
- macOS
- Xcode 14.0 or later
- iOS 15.0+ deployment target

### Installation

1. Clone the repository:
   ```bash
   git clone git@github.com:dsnarne/MenuUI.git
   cd MenuUI
   ```

2. Open in Xcode:
   - File → New → Project
   - Choose iOS → App
   - Name: `IntroSwiftApp`
   - Interface: SwiftUI
   - Language: Swift

3. Add files to project:
   - Drag all files from `IntroSwiftApp/` folder into Xcode
   - Enable "Copy items if needed" and "Add to targets"

4. Run:
   - Select iOS Simulator
   - Press ⌘R

## Key Concepts

- SwiftUI views and declarative syntax
- State management (@State, @StateObject, @ObservedObject)
- Navigation (NavigationView, NavigationLink)
- Lists and data display
- Forms and user input
- Data persistence (UserDefaults)
- Search and filtering
- Gestures (pinch, drag, pan)
- Custom UI components

## Technologies

- SwiftUI
- Swift
- UserDefaults

## License

This project is open source and available under the MIT License.

## Resources

- [Swift Documentation](https://swift.org/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Apple Developer Documentation](https://developer.apple.com/documentation/)
