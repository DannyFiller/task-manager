import 'package:flutter/material.dart';

class Uiprovider with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    dividerColor: Colors.white54,
  );

  // final darkTheme = ThemeData(
  //   primarySwatch: Colors.grey,
  //   primaryColor: Colors.black,
  //   brightness: Brightness.dark,
  //   dividerColor: Colors.black12,
  // );
  final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.grey,
      scaffoldBackgroundColor: Colors.black, // Nền của các Scaffold
      cardColor: Colors.grey[800], // Màu nền cho các Card
      dividerColor: Colors.black12, // Màu divider giữa các item

      // Định nghĩa ColorScheme để sử dụng màu sắc dễ dàng hơn
      colorScheme: ColorScheme.dark(
        primary: Colors.grey[900]!, // Màu chính
        onPrimary: Colors.white, // Màu văn bản trên nền primary
        background: Colors.black, // Màu nền chung
        surface: Colors.grey[800]!, // Màu nền của các widget
      ),

      // Nút bấm
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[900], // Màu nền của ElevatedButton
          foregroundColor: Colors.white, // Màu chữ của ElevatedButton
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Bo góc của nút
          ),
        ),
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        color: Colors.black, // Màu nền của AppBar
        iconTheme: IconThemeData(color: Colors.white), // Màu của các biểu tượng
        titleTextStyle: TextStyle(
          color: Colors.white, // Màu tiêu đề
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // TextField
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[850], // Màu nền TextField
        labelStyle: const TextStyle(color: Colors.white), // Màu của label
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[700]!), // Màu viền
          borderRadius: BorderRadius.circular(8), // Bo góc của TextField
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[500]!),
        ),
      ),

      // FloatingActionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.grey, // Màu nền của FAB
        foregroundColor: Colors.white, // Màu biểu tượng trên FAB
      ),

      // Icon
      iconTheme: const IconThemeData(
        color: Colors.white, // Màu biểu tượng chung
      ),

      // Typography (sử dụng các tên mới)
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold), // Thay cho headline1
        displayMedium:
            TextStyle(color: Colors.white, fontSize: 28), // Thay cho headline2
        bodyLarge:
            TextStyle(color: Colors.white, fontSize: 16), // Thay cho bodyText1
        bodyMedium: TextStyle(
            color: Colors.white70, fontSize: 14), // Thay cho bodyText2
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black, // Nền của BottomNavigationBar
        selectedItemColor: Colors.white, // M
      ));

  changeTheme() {
    _isDark = !isDark;
    notifyListeners();
  }

  init() async {
    notifyListeners();
  }
}
