import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

// kotlin copy method in flutter https://github.com/dart-lang/language/issues/137 -> freezed https://pub.dev/packages/freezed
// how to use freezed https://tomicriedel.medium.com/flutter-freezed-the-complete-crashcourse-c942e9aa2428
@freezed
// run the following in the project directory after changing this file:
// flutter pub run build_runner build --delete-conflicting-outputs
class Book with _$Book {
  const factory Book({
    required String id,
    required String title,
    required String author,
    required int year,
    required bool lent,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  @override
  bool operator ==(Object other) {
    return other is Book &&
        other.runtimeType == runtimeType &&
        other.id == id;
  }
}