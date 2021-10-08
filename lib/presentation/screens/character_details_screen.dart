import 'package:characters_actors/data/models/character.dart';
import 'package:characters_actors/helpers/constants/myColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character? character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character!.nickname!,
          style: TextStyle(
            color: MyColors.mywhite,
          ),
        ),
        background: Hero(
          tag: character!.charId as Object,
          child: character!.img!.isNotEmpty
              ? FadeInImage.assetNetwork(
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: 'assets/images/loading.gif',
                  image: character!.img!,
                  fit: BoxFit.cover,
                )
              : Image.asset('assets/images/placeholder.png'),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.mywhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.mywhite,
              fontSize: 16,
            )),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      endIndent: endIndent,
      height: 30,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 14),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo('job: ', character!.occupation!.join(' / ')),
                  buildDivider(315),
                  characterInfo('appeared in: : ', character!.category!),
                  buildDivider(240),
                  characterInfo('seasons: : ', character!.appearance!.join(' / ')),
                  buildDivider(270),
                  characterInfo('status: : ', character!.status!),
                  buildDivider(290),
                  SizedBox(
                    height: 500,
                  ),
                ],
              ),
            ),
          ])),
        ],
      ),
    );
  }
}
