import 'package:freezed_annotation/freezed_annotation.dart';

part 'Book.freezed.dart';
part 'Book.g.dart';

// kotlin copy method in flutter https://github.com/dart-lang/language/issues/137 -> freezed https://pub.dev/packages/freezed
// how to use freezed https://tomicriedel.medium.com/flutter-freezed-the-complete-crashcourse-c942e9aa2428
@freezed
// run the following in the project directory after changing this file:
// flutter pub run build_runner build --delete-conflicting-outputs
class Book with _$Book {
  const factory Book({
    required int id,
    required String title,
    required String author,
    required int year,
    required bool lent,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  static const Book invalid = Book(id: 0, title: '', author: '', year: 0, lent: false);
}