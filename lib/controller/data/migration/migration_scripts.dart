/// Commiting here is essentially final. Anytime we need to modify our db's structure, we write the script
/// for it here, then add it to the migrations map. The index number in migrations is always equal to the
/// number of variables in this file.

/// 1: initialize app. My first relational DB!
const String initializeApp =
    'CREATE TABLE IF NOT EXISTS exercise (id INTEGER PRIMARY KEY, totalCount INTEGER, name TEXT, countForSets INTEGER, targets TEXT, resistance INTEGER, equipment TEXT, steps TEXT, style TEXT, notes TEXT);';
