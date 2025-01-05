import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tamadrop_riverpod/infra/service/sqlite/initialize_sql.dart';
import 'package:tamadrop_riverpod/infra/service/sqlite/sqlite.dart';
import 'package:tamadrop_riverpod/presentation/app.dart';

class DBSetupApp extends StatelessWidget {
  const DBSetupApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: DBInstantiation.openDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        } else {
          return ProviderScope(
            overrides: [
              sqfliteProvider.overrideWithValue(snapshot.data!),
            ],
            child: App(),
          );
        }
      },
    );
  }
}
