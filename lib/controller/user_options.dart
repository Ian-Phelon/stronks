import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import './controller.dart';
import '../model/model.dart' as theme show StronksTheme;

final _dbHelper = DataHelper();
const String _table = 'userOptions';

// final UserOptionValue openedAppOnce =
//     UserOptionValue(id: null, optionTitle: 'openedApp', optionValue: 1);

class UserOptions extends ChangeNotifier {
  UserOptions._();

  static final UserOptions _instance = UserOptions._();
  static UserOptions get instance => _instance;

  Future<void> initialize() async {
    final dataList = await _dbHelper.getDataForRepo(_table);
    final bool check = userOpenedApp && dataList.isEmpty;
    if (check) await firstTime();
    loadThemes();
    print(themes.length);
    await fetchAndSetUserOptionsTableData();
  }

  static const List<String> resistanceValues = ['lb.', 'kg.'];
  List<ThemeData> themes = [];
  void loadThemes() {
    themes.clear();
    themes.add(theme.StronksTheme.lightMode);
    themes.add(theme.StronksTheme.darkMode);
    notifyListeners();
  }

  String getUserResistanceValue() =>
      resistanceValues[userOptions[1].optionValue!];
  ThemeData getCurrentTheme() {
    // toggleUsesDarkMode(true);

    return themes[userOptions[0].optionValue!];
  }

  final bool userOpenedApp = true;
  late List<UserOptionValue> userOptions;
  late UserOptionValue? selectedOption;

  void selectOption(
      {required int userOptionsIndex, required int updatedValue}) {
    selectedOption =
        userOptions[userOptionsIndex].copyWith(optionValue: updatedValue);
    notifyListeners();
  }

  /// [0: usesDarkMode, 1: usesMetric]
  bool getOptionValue({required int userOptionsIndex}) =>
      intToBool(userOptions[userOptionsIndex].optionValue!);

  Future<void> fetchAndSetUserOptionsTableData() async {
    final dataList = await _dbHelper.getDataForRepo(_table);

    List<UserOptionValue> convertedList = dataList
        .map<UserOptionValue>(
          (item) => UserOptionValue(
            id: item['id'],
            optionTitle: item['optionTitle'],
            optionValue: item['optionValue'],
          ),
        )
        .toList();
    userOptions = convertedList;

    notifyListeners();
    print('something IN USER OPTIONS');
  }

  Future<void> firstTime() async {
    final UserOptionValue _darkMode =
        UserOptionValue(id: null, optionTitle: 'usesDarkMode', optionValue: 0);
    final UserOptionValue _metric =
        UserOptionValue(id: null, optionTitle: 'usesMetric', optionValue: 0);
    final UserOptionValue _removedAds = UserOptionValue(
        id: null, optionTitle: 'userRemovedAds', optionValue: 0);
    final Database db = await _dbHelper.database;
    await db.transaction((txn) => txn.insert(
          _table,
          _darkMode.toMap(),
        ));
    await db.transaction((txn) => txn.insert(
          _table,
          _metric.toMap(),
        ));
    await db.transaction((txn) => txn.insert(
          _table,
          _removedAds.toMap(),
        ));
    notifyListeners();
  }

  Future<void> toggleUserRemovedAds() async {
    selectOption(userOptionsIndex: 2, updatedValue: 1);
    var option = selectedOption!;
    await _dbHelper.update(option.toMap(), _table);
    await fetchAndSetUserOptionsTableData();
  }

  Future<void> toggleUsesDarkMode(bool v) async {
    selectOption(userOptionsIndex: 0, updatedValue: boolToInt(v));
    var option = selectedOption!;
    await _dbHelper.update(option.toMap(), _table);
    await fetchAndSetUserOptionsTableData();
    // getCurrentTheme();
  }

  Future<void> toggleUsesMetric(bool v) async {
    selectOption(userOptionsIndex: 1, updatedValue: boolToInt(v));
    var option = selectedOption!;
    await _dbHelper.update(option.toMap(), _table);
    await fetchAndSetUserOptionsTableData();
  }

  int boolToInt(bool v) => v ? 1 : 0;
  bool intToBool(int v) => v == 1 ? true : false;
}

/// Representation of how user options are stored in the DB. optionValue will
/// be either a 1 or 0 (bool).
class UserOptionValue {
  final int? id;
  final String? optionTitle;
  int? optionValue;
  UserOptionValue({
    required this.id,
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
