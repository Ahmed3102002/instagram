import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/pages/auth_pages/log_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social/pages/root_page.dart';
import 'package:social/providers/comment_provider.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/providers/like_provider.dart';
import 'package:social/providers/search_provider.dart';
import 'package:social/providers/selected_page_provider.dart';
import 'package:social/providers/show_pass_provider.dart';
import 'package:social/providers/show_posts_provider.dart';
import 'package:social/providers/themes_provider.dart';
import 'package:social/providers/user_data_provider.dart';
import 'package:social/providers/user_image_provider.dart';
import 'package:social/providers/video_provider.dart';
import 'package:social/utils/constants.dart';
import 'package:social/utils/themes/dark_theme.dart';
import 'package:social/utils/themes/light_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShowPassProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => IsLoadingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => IsLikeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserImageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShowPostsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VideoProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.getIsDarkTheme
                ? DarkThemeData.themeData()
                : LightThemeData.themeData(),
            routes: ConstantVariables.routes,
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? LogInPage.routName
                : RootPage.routName,
          );
        },
      ),
    );
  }
}
