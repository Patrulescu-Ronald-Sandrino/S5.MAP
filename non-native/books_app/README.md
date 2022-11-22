# books_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# my notes
I'm using *freezed* library to reduce boilerplate code. (Ex: Book.dart)  
If you want to use it, you need to run the following command:  
```flutter pub run build_runner build --delete-conflicting-outputs```  

It has to be run just once, after you write the @freezed class. But you can also add a task to run
before launch in the run configuration w/ the full path to the flutter bin and the args above.