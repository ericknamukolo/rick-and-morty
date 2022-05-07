import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/constants/colors.dart';
import 'package:rick_and_morty/providers/characters.dart';
import 'package:rick_and_morty/providers/themes.dart';
import 'package:rick_and_morty/screens/home_screen.dart';

void main() {
  runApp(const RickAndMorty());
}

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RADCharacters()),
        ChangeNotifierProvider(create: (context) => RADTheme()),
      ],
      child: Consumer<RADTheme>(
        builder: (context, theme, __) => MaterialApp(
          title: 'Rick And Morty',
          theme: ThemeData(
            fontFamily: 'Poppins',
            brightness: theme.isDark ? Brightness.dark : Brightness.light,
            appBarTheme: AppBarTheme(
              color: theme.isDark ? null : kPrimaryColor,
            ),
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
