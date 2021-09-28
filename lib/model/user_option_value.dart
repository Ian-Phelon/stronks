import 'dart:convert';

/// Representation of how user options are stored in the DB. optionValue will
/// be either a 1 or 0 (bool).
class UserOptionValue {
  final int? id;
  final String? optionTitle;
  int? optionValue;
  UserOptionValue({
    this.id,
    required this.optionTitle,
    required this.optionValue,
  });

  UserOptionValue copyWith({
    int? id,
    String? optionTitle,
    int? optionValue,
  }) {
    return UserOptionValue(
      id: id ?? this.id,
      optionTitle: optionTitle ?? this.optionTitle,
      optionValue: optionValue ?? this.optionValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'optionTitle': optionTitle,
      'optionValue': optionValue,
    };
  }

  factory UserOptionValue.fromMap(Map<String, dynamic> map) {
    return UserOptionValue(
      id: map['id'],
      optionTitle: map['optionTitle'],
      optionValue: map['optionValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserOptionValue.fromJson(String source) =>
      UserOptionValue.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserOptionValue(id: $id, optionTitle: $optionTitle, optionValue: $optionValue)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserOptionValue &&
        other.id == id &&
        other.optionTitle == optionTitle &&
        other.optionValue == optionValue;
  }

  @override
  int get hashCode => id.hashCode ^ optionTitle.hashCode ^ optionValue.hashCode;
}
