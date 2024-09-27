import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:task_manager/pages/DangNhap.dart';
import 'package:task_manager/providers/ListVSM.dart';
import 'package:task_manager/providers/UIProvider.dart';
import 'package:task_manager/utilities/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('vi', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListVSM()),
        ChangeNotifierProvider(create: (context) => Uiprovider()..init()),
      ],
      child:
          Consumer<Uiprovider>(builder: (context, Uiprovider notifier, child) {
        return MaterialApp(
          // theo mặc định của máy
          themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
          // theo cài chế độ sáng tốitối
          darkTheme: notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
          debugShowCheckedModeBanner: false,
          home: const Scaffold(
            body: DangNhap(),
          ),
        );
      }),
    );
  }
}
