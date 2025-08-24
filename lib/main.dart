
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secura_entry/providers/auth_provider.dart';
import 'package:secura_entry/screens/common/localization_service.dart';
import 'package:secura_entry/screens/auth/login_screen.dart';
import 'package:secura_entry/screens/common/help.dart';
import 'package:secura_entry/screens/common/language_screen.dart';
import 'package:secura_entry/screens/common/notification_screen.dart';
//import 'package:secura_entry/screens/common/localization_service.dart';
import 'package:secura_entry/screens/common/privacy.dart';
import 'package:secura_entry/screens/resident/dashboard.dart';
import 'package:secura_entry/screens/admin/PassLogsScreen.dart';
import 'package:secura_entry/screens/guard/manual_entry.dart';
import 'screens/resident/add_guest.dart';
import 'screens/resident/guest_logs.dart';
import 'screens/guard/scan_qr.dart';
import 'screens/common/profile.dart';
import 'screens/common/splash.dart';
import 'screens/common/settings.dart';
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/admin/BulkAddGuestScreen.dart';
import 'screens/admin/ManageUsersScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const SecuraEntryApp());
}

class SecuraEntryApp extends StatelessWidget {
  const SecuraEntryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => LocalizationService()), // Add LocalizationService
      ],
      child: Consumer<LocalizationService>(
        builder: (context, localizationService, child) {
          return MaterialApp(
            title: 'SecuraEntry',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: const Color(0xFF41C1BA),
              scaffoldBackgroundColor: const Color(0xFFFFFFFF),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF41C1BA),
                iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
                titleTextStyle: TextStyle(
                  color: Color(0xFF205755),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              cardColor: Colors.white,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Color(0xFF41C1BA)),
                bodyMedium: TextStyle(color: Color(0xFF41C1BA)),
                titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            locale: localizationService.locale, // Set app-wide locale
            home: const SplashHandler(),
            routes: {
              '/splash': (context) => const SplashScreen(),
              '/dashboard': (context) => DashboardScreen(),
              '/add-guest': (context) => AddGuestScreen(),
              '/guest-logs': (context) => GuestLogsScreen(),
              '/profile': (context) =>  ProfileScreen(),
              '/settings': (context) =>  SettingsScreen(),
              '/scan-qr': (context) => ScanQRScreen(),
              '/manual-entry': (context) => ManualEntry(),
              '/admin-dashboard': (context) => AdminDashboardScreen(),
              '/bulk-add-guest': (context) => BulkAddGuestScreen(),
              '/manage-users': (context) => ManageUsersScreen(),
              '/pass-logs': (context) => PassLogsScreen(),
              '/login': (context) => LoginScreen(),
              '/language': (context) =>  LanguageScreen(),
              '/notifications': (context) =>  NotificationScreen(),
              '/privacy': (context) =>  PrivacyScreen(),
              '/help': (context) =>  HelpScreen(),
            },
          );
        },
      ),
    );
  }
}

class SplashHandler extends StatefulWidget {
  const SplashHandler({super.key});

  @override
  _SplashHandlerState createState() => _SplashHandlerState();
}

class _SplashHandlerState extends State<SplashHandler> {
  @override
  void initState() {
    super.initState();
    navigateAfterSplash();
  }

  Future<void> navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}