import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosseti_project/Blocs/send_messege_bloc.dart';
import 'package:rosseti_project/screens/mainpage.dart';
import 'package:rosseti_project/screens/phone_number.dart';
import 'package:rosseti_project/repositories/repositories_login.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TitleBloc>(
          create: (context) => TitleBloc(),
        ),
        BlocProvider<ExistingTextBloc>(
          create: (context) => ExistingTextBloc(),
        ),
        BlocProvider<ExistingImageBloc>(
          create: (context) => ExistingImageBloc(),
        ),
        BlocProvider<ExistingVideoBloc>(
          create: (context) => ExistingVideoBloc(),
        ),
        BlocProvider<ProposedTextBloc>(
          create: (context) => ProposedTextBloc(),
        ),
        BlocProvider<ProposedImageBloc>(
          create: (context) => ProposedImageBloc(),
        ),
        BlocProvider<ProposedVideoBloc>(
          create: (context) => ProposedVideoBloc(),
        ),
        BlocProvider<PositiveEffectBloc>(
          create: (context) => PositiveEffectBloc(),
        ),
        BlocProvider<TopicBloc>(
          create: (context) => TopicBloc(),
        ),
      ],
      child: const Rosseti(),
    ),
  );
}

class Rosseti extends StatelessWidget {
  const Rosseti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<String?>(
        future: PhoneNumberCheker().getToken(),
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
        textTheme: const TextTheme(
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
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          const SizedBox(height: 151.0),
          Image.asset('assets/sharos.png'),
          const SizedBox(height: 30.0),
          Text(
            'seti.inno',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Рацианализатор',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'ABeeZee',
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: 120.0, top: 0.0, right: 35.0, left: 35.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 58,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PhoneNumber(),
                ),
              );
            },
            child: const Text(
              'Регистрация',
            ),
          ),
        ),
      ),
    );
  }
}
