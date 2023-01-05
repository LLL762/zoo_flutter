import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:zoo_flutter/src/features/content/tasks/services/i_task_service.dart';
import 'package:zoo_flutter/src/features/content/tasks/tasks_list/presentation/tasks_list.dart';
import 'package:zoo_flutter/src/features/content/tasks/tasks_routes.dart';
import 'package:zoo_flutter/src/features/nav/preferences/model/theme_model.dart';
import 'package:zoo_flutter/src/features/nav/preferences/service/i_preference_service.dart';
import 'package:zoo_flutter/src/widgets/screen_skeleton.dart';
import 'src/features/authentication/presentation/login_form.dart';

void main() async {
  final preferenceService = IPreferenceService.factory();
  final themeModel = await preferenceService.getTheme();
  setPathUrlStrategy();

  runApp(MyApp(themeModel: themeModel));
}

final ILogInService loginService = ILogInService("");

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: TasksRoutes().get(),
    ),
  ],
);

/// The main app.
class MyApp extends StatelessWidget {
  final ThemeModel themeModel;

  const MyApp({super.key, required this.themeModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeModel;
      },
      child: Consumer<ThemeModel>(
        builder: (context, value, child) {
          return MaterialApp.router(
            theme: value.toThemeData(context),
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

/// The home screen
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenSkeleton(
        body: Center(child: Column(children: const [LoginForm()])),
        logInService: loginService);
  }
}

/// The details screen
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800, minWidth: 350),
      child: Scaffold(
        appBar: AppBar(title: const Text('Details Screen')),
        body: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Go back to the Home screen'),
                  ),
                  TasksList(ITaskService("")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
