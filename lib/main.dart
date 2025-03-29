import 'package:flutter/material.dart';
import 'package:form_validation/screens/my_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.all(Colors.lightBlue),
        ),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: Colors.lightBlue,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue),
          ),
        ),
      ),
      home: const MyForm(),
    );
  }
}
