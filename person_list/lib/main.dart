import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/local_db_provider.dart';
import 'screen/profiles_screen.dart';
import 'services/sqlite_service.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(
        create: (context) => SqliteService(),
      ),
      ChangeNotifierProvider(
        create: (context) => LocalDatabaseProvider(
          context.read<SqliteService>(),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProfilesScreen(),
    );
  }
}