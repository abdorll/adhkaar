import 'package:adhkaar/model/adhkaar_model.dart';
import 'package:adhkaar/screens/home_page.dart';
import 'package:adhkaar/themes/app_color.dart';
import 'package:adhkaar/utils/app_consts.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AdhkaarModelAdapter());
  await Hive.openBox<AdhkaarModel>(AppConst.ADHKAAR_DRAFT_KEY);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final botToastBuilder = BotToastInit();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: AppConst.APP_NAME,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return botToastBuilder(context, child);
            },
            navigatorObservers: [BotToastNavigatorObserver()],
            theme: ThemeData(
              primaryColor: AppColors.primaryColor,
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              useMaterial3: true,
            ),
            home: const MyHomePage(title: AppConst.APP_NAME),
          );
        });
  }
}
