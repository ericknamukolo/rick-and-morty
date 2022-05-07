import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/constants/colors.dart';
import 'package:rick_and_morty/constants/text_styles.dart';
import 'package:rick_and_morty/providers/characters.dart';
import 'package:rick_and_morty/providers/themes.dart';
import 'package:rick_and_morty/widgets/character_card.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  int pageNumber = 1;
  final _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        // await nextPage().then((_) => _scrollController.animateTo(70,
        //     duration: Duration(seconds: 1), curve: Curves.easeIn));

      }
    });
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<RADCharacters>(context, listen: false)
          .fetchCharacters(pageNumber);
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          await Provider.of<RADCharacters>(context, listen: false)
              .fetchCharacters(pageNumber++);
          setState(() {
            _isLoading = false;
          });
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.navigate_next_rounded,
          color: Colors.white,
        ),
      ),
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
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0),
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
                  GestureDetector(
                    onTap: () async {
                      await launch('https://ericknamukolo.github.io/');
                    },
                    child: Text(
                      'Erick Namukolo',
                      style: kBodyTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: _isLoading
                    ? Shimmer.fromColors(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          itemCount: 10,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                        ),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                      )
                    : RefreshIndicator(
                        color: kPrimaryColor,
                        onRefresh: () async {
                          await data.fetchCharacters(1);
                        },
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) => CharacterCard(
                            img: data.availableCharacters[index].imgUrl,
                            gender: data.availableCharacters[index].gender,
                            status: data.availableCharacters[index].status,
                            name: data.availableCharacters[index].name,
                          ),
                          itemCount: data.availableCharacters.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
