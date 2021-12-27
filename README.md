# avy

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# avy

## In case of problems with pod install or xcode build:
- flutter clean
- delete /ios/Pods
- delete /ios/Podfile.lock
- flutter pub get
- from inside ios folder: pod install Run

for more details please check: 
- [Flutter: CocoaPods's specs repository is too out-of-date to satisfy dependencies](https://stackoverflow.com/questions/64443888/flutter-cocoapodss-specs-repository-is-too-out-of-date-to-satisfy-dependencies/64474526#64474526)

- In Flutter pod install should not called manually. To run pod install
execute the following commands:
-- flutter clean
-- flutter pub get
-- flutter build ios.
