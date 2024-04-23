import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perpus_pram/theme/dark_theme.dart';
import 'package:perpus_pram/theme/light_theme.dart';
import 'app/routes/app_pages.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();
  initializeDateFormatting().then((_) {
    runApp(
      GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        theme: lightTheme,
        darkTheme: darkTheme,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  });
}
