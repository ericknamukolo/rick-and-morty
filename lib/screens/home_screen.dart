import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/constants/colors.dart';
import 'package:rick_and_morty/constants/text_styles.dart';
import 'package:rick_and_morty/providers/characters.dart';
import 'package:rick_and_morty/providers/themes.dart';
import 'package:rick_and_morty/widgets/character_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageNumber = 1;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<RADCharacters>(context, listen: false)
          .fetchCharacters(pageNumber);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rick & Morty',
          style: kBodyTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Consumer<RADTheme>(
            builder: (context, theme, __) => IconButton(
              onPressed: () {
                theme.toggleTheme();
              },
              icon: Icon(
                theme.isDark
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<RADCharacters>(
        builder: (context, data, __) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Built by',
                    style: kBodyTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Erick Namukolo',
                    style: kBodyTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) => CharacterCard(),
                  itemCount: data.availableCharacters.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
