import 'package:calculate_dite/services/create_account_provider.dart';
import 'package:calculate_dite/core/constants/route_names.dart';
import 'package:calculate_dite/routes/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:calculate_dite/core/constants/app_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDYu5hcVWkZlu01kxZFtKVR0mFUex_JklY',
      appId: '1:38914024186:android:672a5ab2e60c5e98e05f43',
      messagingSenderId: '38914024186',
      projectId: 'calculate-diet',
      storageBucket: 'calculate-diet.appspot.com',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          debugPrint(AppText.someThingWentWrong);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => UserManagementProvider(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textTheme: const TextTheme(
                  displayLarge: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  displayMedium: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  displaySmall: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  bodyLarge: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  bodyMedium: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  bodySmall: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              onGenerateRoute: AppRoutes.namedRoutes,
              initialRoute: RouteNames.showUserScreen,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
