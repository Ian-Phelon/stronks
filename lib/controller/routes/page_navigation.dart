import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/constants.dart';
import 'package:stronks/view/view.dart';

import '../routes/pages/pages.dart';
import '../../model/model.dart' show Exercise;
import '../controller.dart' show ExerciseRepository;

class StronksRouterDelegate extends RouterDelegate<StronksPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<StronksPath> {
  StronksRouterDelegate() {
    // This part is important because we pass the notification
    // from RoutePageManager to RouterDelegate. This way our navigation
    // changes (e.g. pushes) will be reflected in the address bar
    pageManager.addListener(notifyListeners);
  }
  final RoutePageManager pageManager = RoutePageManager();

  /// In the build method we need to return Navigator using [navigatorKey]
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoutePageManager>.value(
      value: pageManager,
      child: Consumer<RoutePageManager>(builder: (context, pageManager, child) {
        return Navigator(
          key: navigatorKey,
          onPopPage: _onPopPage,
          pages: List.of(pageManager.pages),
        );
      }),
    );
  }

  ///used by the navigator
  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }

    /// Notify the PageManager that page was popped
    pageManager.didPop(route);
    notifyListeners();
    return true;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => pageManager.navigatorKey;

  @override
  Future<void> setNewRoutePath(StronksPath configuration) async {
    await pageManager.setNewRoutePath(configuration);
  }
}

class RoutePageManager extends ChangeNotifier {
  static RoutePageManager of(BuildContext context) {
    return Provider.of<RoutePageManager>(context, listen: false);
  }

  // ExerciseRepository? exerciseRepo;

  /// Here we are storing the current list of pages
  List<Page> get pages => List.unmodifiable(_pages);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final List<Page> _pages = [
    DashPage(),
  ];

  StronksPath get currentPath {
    return parseRoute(Uri.parse(_pages.last.name!));
  }

  void didPop(Route route) {
    _pages.remove(route.settings);
    notifyListeners();
  }

  /// This is where we handle new route information and manage the pages list
  Future<void> setNewRoutePath(StronksPath configuration) async {
    if (configuration.isUnknownPage) {
      // Handling 404
      _pages.add(
        MaterialPage(
          child: ErrorScreen(),
          key: UniqueKey(),
          name: '/404',
        ),
      );
    } else if (configuration.isExerciesPage) {
      _pages.removeWhere(
        (e) => e.key != Key('DashboardPage'),
      );
      _pages.add(
        MaterialPage(
          child: Consumer<ExerciseRepository>(
            builder: (_, repo, __) => ExercisesScreen(),
          ),
          // child: ExercisesScreen(),),
          // unique?
          key: UniqueKey(),
          name: '/exercises',
          maintainState: true,
        ),
      );
    } else if (configuration.isCreateExerciseScreenPage) {
      // _pages.removeLast();
      _pages.add(
        MaterialPage(
          child: CreateExerciseScreen(),
          // unique?
          key: UniqueKey(),
          name: '/exercises/create_exercise',
        ),
      );
    } else if (configuration.isEditExerciseScreenPage) {
      _pages.add(
        EditExercisePage(),
      );
    } else if (configuration.isCircuitsPage) {
      _pages.add(
        MaterialPage(
          child: CircuitsScreen(),
          // unique?
          key: UniqueKey(),
          name: '/circuits',
        ),
      );
    } else if (configuration.isStatsPage) {
      _pages.add(
        MaterialPage(
          child: StatsScreen(),
          // unique?
          key: UniqueKey(),
          name: '/stats',
        ),
      );
    } else if (configuration.isTpPage) {
      _pages.add(
        MaterialPage(
          child: TradingPlatformScreen(),
          // unique?
          key: UniqueKey(),
          name: '/tp',
        ),
      );
    } else if (configuration.isDashPage) {
      // Restoring to dash
      _pages.removeWhere(
        (element) => element.key != const Key('DashboardPage'),
      );
    }
    notifyListeners();
    return;
  }

  void toExercises() {
    setNewRoutePath(StronksPath.exercises());
  }

  void toCreateExerciseScreen() {
    setNewRoutePath(StronksPath.createExerciseScreen());
  }

  void toEditExerciseScreen(Exercise e) {
    setNewRoutePath(StronksPath.editExerciseScreen(e));
  }

  void toCircuits() {
    setNewRoutePath(StronksPath.circuits());
  }

  void toStats() {
    setNewRoutePath(StronksPath.stats());
  }

  void toTP() {
    setNewRoutePath(StronksPath.tp());
  }

  void resetToHome() {
    setNewRoutePath(StronksPath.dash());
  }
}

StronksPath parseRoute(Uri uri) {
  // Handle '/'
  if (uri.pathSegments.isEmpty) {
    return StronksPath.dash();
  }

  // Handle first path segment
  if (uri.pathSegments.length == 1) {
    if (uri.pathSegments[0] == 'exercises') return StronksPath.exercises();
    if (uri.pathSegments[0] == 'circuits') return StronksPath.circuits();
    if (uri.pathSegments[0] == 'tp') return StronksPath.tp();
    if (uri.pathSegments[0] == 'stats') return StronksPath.stats();
  }

  // Handle unknown routes
  return StronksPath.unknown();
}

class StronksRouteInformationParser
    extends RouteInformationParser<StronksPath> {
  @override
  Future<StronksPath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    return parseRoute(uri);
  }

  @override
  RouteInformation restoreRouteInformation(StronksPath config) {
    if (config.isUnknownPage) RouteInformation(location: '/404');
    if (config.isDashPage) RouteInformation(location: '/');
    if (config.isExerciesPage) RouteInformation(location: '/exercises');
    return RouteInformation(location: 'unknown');
  }
}

class StronksPath {
  final String id;

  StronksPath.dash() : id = 'dash';
  StronksPath.exercises() : id = 'exercises';
  StronksPath.createExerciseScreen() : id = 'create_exercise';
  StronksPath.editExerciseScreen(Exercise e) : id = 'edit_exercises';
  StronksPath.circuits() : id = 'circuits';
  StronksPath.createCricuit() : id = 'create_circuit';
  StronksPath.editCircuit() : id = 'edit_circuits';
  StronksPath.tp() : id = 'tp';
  StronksPath.stats() : id = 'stats';
  StronksPath.unknown() : id = 'unknown';

  bool get isDashPage => id == 'dash';
  bool get isExerciesPage => id == 'exercises';
  bool get isCreateExerciseScreenPage => id == 'create_exercise';
  bool get isEditExerciseScreenPage => id == 'edit_exercises';
  bool get isCircuitsPage => id == 'circuits';
  bool get isCreateCircuitPage => id == 'create_circuit';
  bool get isEditCircuitPage => id == 'edit_circuits';
  bool get isTpPage => id == 'tp';
  bool get isStatsPage => id == 'stats';
  bool get isUnknownPage => id == 'unknown';
}
