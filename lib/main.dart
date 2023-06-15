import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:theming_demo/app_theme.dart';
import 'package:theming_demo/book_model.dart';
import 'package:theming_demo/detail_screen.dart';

import 'book_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: 'root',
        builder: (BuildContext context, GoRouterState state) =>
            const BooksScreen(),
        routes: [
          GoRoute(
            path: 'detail',
            name: 'detail',
            builder: (BuildContext context, GoRouterState state) =>
                DetailScreen(book: state.extra as BookModel),
          ),
        ],
      ),
    ],
  );
  ThemeMode themeMode = ThemeMode.light;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: appTheme(Brightness.light, true),
      darkTheme: appTheme(Brightness.dark, true),
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: appTheme(Brightness.light, true),
    //   darkTheme: appTheme(Brightness.dark, true),
    //   themeMode: themeMode,
    //   debugShowCheckedModeBanner: false,
    //   home: BooksScreen(),
    //   home: MyHomePage(
    //     title: 'Flutter Demo Home Page',
    //     onModeUpdated: (updatedThemeMode) {
    //       setState(() {
    //         themeMode = updatedThemeMode;
    //       });
    //     },
    //   ),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key, required this.title, required this.onModeUpdated});

  final String title;
  final Function(ThemeMode) onModeUpdated;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Brightness? currentBrightness;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  currentBrightness ??=
                      MediaQuery.of(context).platformBrightness;
                  print(currentBrightness);
                  bool isDarkMode = currentBrightness == Brightness.dark;
                  widget.onModeUpdated(
                      isDarkMode ? ThemeMode.light : ThemeMode.dark);
                  currentBrightness =
                      isDarkMode ? Brightness.light : Brightness.dark;
                },
                icon: const Icon(Icons.lightbulb),
                label: const Text('hi'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
