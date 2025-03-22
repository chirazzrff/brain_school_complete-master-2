import 'package:brain_school/routes.dart';
import 'package:brain_school/screens/admin/admin_dashboard.dart';
import 'package:brain_school/screens/splash_screen/splash_screen.dart';
import 'package:brain_school/screens/signup_screen/signup_screen.dart';
import 'package:brain_school/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wfpdmeseylfzlgxgnorh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndmcGRtZXNleWxmemxneGdub3JoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIwNzcyMzYsImV4cCI6MjA1NzY1MzIzNn0.RhU-lIQN-FZTQC16eJldztFCwhOqEvzBXC8FvtgZ9ZY',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, device) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School Brain',
        theme: CustomTheme().baseTheme,
        initialRoute: SplashScreen.routeName,
        routes: {
          ...routes,
          SignUpScreen.routeName: (context) => SignUpScreen(),
          AdminDashboard.routeName: (context) => AdminDashboard(),
        },
      );
    });
  }
}