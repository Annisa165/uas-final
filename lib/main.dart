import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uts/screens/detail_screen.dart';
import 'package:uts/screens/game_list_screen.dart';
import 'package:uts/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.grey[50],
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // Warna utama yang akan digunakan
    const primaryColor = Colors.blueGrey;
    const accentColor = Color(0xFFFFA000); // Oranye amber sebagai aksen

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Store UI',
      theme: ThemeData(
        brightness: Brightness.light, // Tema terang
        primarySwatch: primaryColor,
        // Warna dasar scaffold
        scaffoldBackgroundColor:
            Colors.grey[100], // Sedikit lebih gelap dari putih
        // Font dasar
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.black87, displayColor: Colors.black87),
        // Tema AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[50],
          foregroundColor: Colors.black87,
          elevation: 0.5,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          iconTheme: const IconThemeData(color: Colors.black54),
        ),
        // Tema Card
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1.5, // Sedikit lebih tebal shadow-nya
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Lebih melengkung
          ),
          margin: const EdgeInsets.only(bottom: 16),
        ),
        // Tema Chip (Kategori)
        chipTheme: ChipThemeData(
          backgroundColor: Colors.white,
          selectedColor: primaryColor[100],
          secondarySelectedColor: primaryColor[100],
          labelStyle: TextStyle(
            color: primaryColor[800],
            fontWeight: FontWeight.w500,
          ),
          secondaryLabelStyle: TextStyle(color: primaryColor[900]),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey[300]!),
          ),
          elevation: 0.5,
          pressElevation: 1.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ), // Padding lebih
        ),
        // Tema TextField (Search Bar)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIconColor: primaryColor[600], // Warna ikon search
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ), // Padding lebih
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25), // Lebih bulat
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: primaryColor.shade300,
              width: 2,
            ), // Border lebih jelas saat fokus
          ),
        ),
        // Tema ListTile (untuk daftar game)
        listTileTheme: ListTileThemeData(
          iconColor: primaryColor[600],
          tileColor: Colors.white, // Default putih (nanti di override di Card)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
        ),
        // Warna aksen
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primaryColor,
        ).copyWith(secondary: accentColor),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        GameListScreen.routeName: (context) => const GameListScreen(),
        DetailScreen.routeName: (context) => const DetailScreen(),
      },
    );
  }
}
