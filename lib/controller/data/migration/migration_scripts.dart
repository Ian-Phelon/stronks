/// Commiting here is essentially final. Anytime we need to modify our db's
/// structure, we write the script for it here, then add it to the migrations
/// map. The index number in migrations is always equal to the number of
/// "version" variables in this file.
part of 'migration.dart';

/// 1: initialize app.
const String initializeApp =
    'CREATE TABLE IF NOT EXISTS exercise (id INTEGER PRIMARY KEY, totalCount INTEGER, name TEXT, countForSets INTEGER, targets TEXT, resistance INTEGER, equipment TEXT, steps TEXT, style TEXT, notes TEXT);';

/// 2
const String secondVersion =
    'CREATE TABLE IF NOT EXISTS performance (id ITEGER PRIMARY KEY, datePerformed TEXT, exerciseId INTEGER, updatedCount INTEGER, currentResistance INTEGER, repsOrHold INTEGER, splitMultiplier INTEGER);';

/// 3
const String thirdVersion =
    'CREATE TABLE IF NOT EXISTS userOptions (id INTEGER PRIMARY KEY, usesMetric INTEGER, darkMode INTEGER) ALTER TABLE exercise ADD COLUMN holdTime INTEGER;';
