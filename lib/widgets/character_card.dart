import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/colors.dart';
import 'package:rick_and_morty/constants/text_styles.dart';

class CharacterCard extends StatelessWidget {
  final String img;
  final String name;
  final String status;
  final String gender;
  const CharacterCard({
    Key? key,
    required this.img,
    required this.name,
    required this.gender,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colour() {
      Color color;
      if (status == 'Alive') {
        color = Colors.green;
      } else if (status == 'Dead') {
        color = Theme.of(context).errorColor;
      } else {
        color = Colors.grey;
      }
      return color;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(.6),
            ),
            height: 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  style: kBodyTextStyle.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      status,
                      style: kBodyTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.circle_rounded,
                      size: 8,
                      color: colour(),
                    ),
                  ],
                ),
                Text(
                  gender,
                  style: kBodyTextStyle.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
