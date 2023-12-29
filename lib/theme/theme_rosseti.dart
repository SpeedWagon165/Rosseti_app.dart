import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../repositories/repositories_login.dart';
import '../screens/mainpage_page.dart';
import '../screens/registration_page.dart';

class Rosseti extends StatelessWidget {
  const Rosseti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2340),
      child: MaterialApp(
        home: FutureBuilder<String?>(
          future: DioBase().getToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Показываем загрузку, пока Future выполняется
            } else {
              if (snapshot.hasData && snapshot.data != null) {
                return const MainPage(); // Если токен получен и не равен null, перейдите на основной экран
              } else {
                return const MyHomePage(); // Если токен не получен или равен null, перейдите на домашний экран
              }
            }
          },
        ),
        debugShowCheckedModeBanner: false,
        title: 'Rosseti',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          listTileTheme: const ListTileThemeData(
            // Задайте здесь желаемые параметры стиля
            leadingAndTrailingTextStyle: TextStyle(
              fontFamily: 'ABeeZee',
              color: Color(0xFF205691),
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            titleTextStyle: TextStyle(
              fontFamily: 'ABeeZee',
              color: Color(0xFF205691),
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              fontFamily: 'ABeeZee',
              color: Color(0xFF205691),
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            headlineLarge: TextStyle(
              fontFamily: 'ABeeZee',
              color: Color(0xFF205691),
              fontWeight: FontWeight.w200,
              fontSize: 55,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'ABeeZee',
              color: Color(0xFF205691),
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            bodySmall: TextStyle(
              fontFamily: 'ABeeZee',
              color: Color(0xFF205691),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            headlineSmall: TextStyle(
              fontFamily: 'ABeeZee',
              color: Color(0xFF205691),
              fontWeight: FontWeight.w400,
              fontSize: 27,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'ABeeZee',
              color: Color(0xFF205691),
              fontWeight: FontWeight.w400,
              fontSize: 36,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              foregroundColor: const Color(0xFF205691),
              backgroundColor: Colors.white,
              textStyle: const TextStyle(
                fontFamily: 'ABeeZee',
                color: Color(0xFF205691),
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontFamily: 'ABeeZee',
            ),
            hintStyle: const TextStyle(
              color: Colors.grey, // Цвет подсказки
              fontSize: 14.0, //
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey, // Цвет границы при неактивном состоянии
                width: 0.1, // Толщина границы при неактивном состоянии
              ),
              borderRadius:
                  BorderRadius.circular(30.0), // Задайте радиус углов границы
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
