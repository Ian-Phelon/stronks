import 'dart:convert';

import 'package:flutter/material.dart'
    show ChangeNotifier, BuildContext, ThemeData;
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import './controller.dart';
import '../model/model.dart' show StronksTheme, UserOptionValue;

final _dbHelper = DataHelper();
const String _table = 'userOptions';

class UserOptions extends ChangeNotifier {
  UserOptions._();

  static final UserOptions _instance = UserOptions._();
  static UserOptions get instance => _instance;
  static UserOptions of(BuildContext context) {
    return Provider.of<UserOptions>(context, listen: false);
  }

  Future<void> initialize() async {
    final dataList = await _dbHelper.getDataForRepo(_table);
    if (dataList.isEmpty) await firstTime();
    loadThemes();
    await fetchAndSetUserOptionsTableData();
  }

  static const List<String> resistanceValues = ['lb.', 'kg.'];
  List<ThemeData> themes = [];
  void loadThemes() {
    themes.clear();
    themes.add(StronksTheme.lightMode);
    themes.add(StronksTheme.darkMode);
    notifyListeners();
  }

  String getUserResistanceValue() =>
      resistanceValues[userOptions[1].optionValue!];
  ThemeData getCurrentTheme() {
    return themes[userOptions[0].optionValue!];
  }

  late List<UserOptionValue> userOptions;
  late UserOptionValue? selectedOption;

  void selectOption(
      {required int userOptionsIndex, required int updatedValue}) {
    selectedOption =
        userOptions[userOptionsIndex].copyWith(optionValue: updatedValue);
    notifyListeners();
  }

  /// [0: usesDarkMode, 1: usesMetric, 2: userRemovedAds]
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

  Future<void> makeNewOption(
      {required String optionTitle, required int optionValue}) async {
    final Database db = await _dbHelper.database;
    var userHasAccount = db.query(_table, limit: 1, offset: 4);
    print(userHasAccount.toString() + 'USEROPTIONS');
    // await db.transaction((txn) => txn.insert(
    //     _table,
    //     UserOptionValue(optionTitle: optionTitle, optionValue: optionValue)
    //         .toMap()));
    notifyListeners();
  }

  Future<void> toggleUserRemovedAds(int updatedValue) async {
    selectOption(userOptionsIndex: 2, updatedValue: updatedValue);
    var option = selectedOption!;
    await _dbHelper.update(option.toMap(), _table);
    await fetchAndSetUserOptionsTableData();
  }

  Future<void> toggleUsesDarkMode(bool v) async {
    selectOption(userOptionsIndex: 0, updatedValue: boolToInt(v));
    var option = selectedOption!;
    await _dbHelper.update(option.toMap(), _table);
    await fetchAndSetUserOptionsTableData();
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
