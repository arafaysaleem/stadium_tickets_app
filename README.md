# stadium_tickets_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application. A few steps to follow before you get started

### Debugging

Run the following before launching the debug process:

```
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Release APK

To generate the release apk run

```
flutter build apk --release --split-per-abi --dart-define=SENTRY_DSN=https://5b4b469222f742d7bf75b291c071c0ca@o1009394.ingest.sentry.io/4504156975857664 --dart-define=BASE_URL=https://stadium-tickets-backend.herokuapp.com/api/v1 --dart-define=API_KEY=STA.Ht_em8HuQhOPAw9BmgpjFg.shgzuVMUjVZvvdV0zlEEth0dBU8u-sFm-pw3LWssGgg
```
