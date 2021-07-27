// import 'migration_scripts.dart';

part 'migration_scripts.dart';

/// Map for assembling our database by version number and accompanied script.
class DbMigrator {
  /// A map for migration scripts. Script strings themselves will be created outside of this map, with variable names in the style of commit messegaes. Refer to DatabaseHelper for table, column, and row strings.
  static final Map<int, String> migrations = {
    1: createExerciseTable,
    2: createPerformanceTable,
    3: createUserOptionsTable,
    // 1: '''SQL script to initialize database tables...''',
    // 2: "SQL script to add new column...",
    // 3: "SQL script to update existing column and update data as well...."
  };
}
