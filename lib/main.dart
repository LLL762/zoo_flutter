import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:zoo_flutter/src/features/authentication/model/log_in_status.dart';
import 'package:zoo_flutter/src/features/authentication/services/i_log_in_service.dart';
import 'package:zoo_flutter/src/features/content/tasks/services/i_task_service.dart';
import 'package:zoo_flutter/src/features/content/tasks/tasks_list/presentation/tasks_list.dart';
import 'package:zoo_flutter/src/features/content/tasks/presentation/task_detail.dart';
import 'package:zoo_flutter/src/features/nav/preferences/model/theme_model.dart';
import 'package:zoo_flutter/src/features/nav/preferences/service/i_preference_service.dart';
import 'package:zoo_flutter/src/features/nav/presentation/preferences/preferences_menu.dart';
import 'package:zoo_flutter/src/widgets/screen_skeleton.dart';
import 'src/features/authentication/presentation/login_form.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
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
      routes: <RouteBase>[
        GoRoute(
            path: 'tasks',
            builder: (BuildContext context, GoRouterState state) {
              return const DetailsScreen();
            },
            redirect: (context, state) async {
              if (await loginService.getLogInStatus() != LogInStatus.logIn) {
                return '/';
              }
              return null;
            },
            routes: [
              GoRoute(
                  path: ':id',
                  builder: (BuildContext context, GoRouterState state) {
                    return TaskDetail(ITaskService(""), state.params['id']!);
                  },
                  redirect: (context, state) async {
                    if (state.params['id'] == null ||
                        await loginService.getLogInStatus() !=
                            LogInStatus.logIn) {
                      return '/';
                    }
                    return null;
                  })
            ]),
      ],
    ),
  ],
);

/// The main app.
class MyApp extends StatelessWidget {
  final preferenceService = IPreferenceService.factory();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return ThemeModel();
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
        body: Center(
            child: Column(children: [
          PreferenceMenu(
            themeModel: ThemeModel(),
          ),
          const LoginForm()
        ])),
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
