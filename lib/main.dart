import 'package:flutter/material.dart';
import 'package:hive_clean_provider_bloc/contact_clean_bloc/presentation/contact_screen/contact_screen.dart';
import 'package:hive_clean_provider_bloc/core/db/app_database.dart';
import 'package:hive_clean_provider_bloc/di.dart';
import 'package:hive_clean_provider_bloc/note_clean_provider/presentation/note_view_model.dart';
import 'note_clean_provider/presentation/note_hive_clean_arc_provider.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  AppDatabase db = AppDatabase();
  await db.init();

  setUpDI();

  runApp(const project_providers());  // to use provider state_management
}


class project_providers extends StatelessWidget {
  const project_providers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => NoteViewModel(sl())),

      // ChangeNotifierProvider(create: (_) => ServerProvider()),
    ], child: MyApp() ,);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const NoteHiveCleanArcProvider(),
      home: const ContactScreen(),
      // home: const TestClasss(),
    );
  }
}

