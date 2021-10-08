import 'package:characters_actors/data/models/character.dart';
import 'package:characters_actors/helpers/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:characters_actors/helpers/constants/myColors.dart';

class CharacterItem extends StatelessWidget {
  Character? character;

  CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: MyColors.mywhite, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, characterDetailsRoute, arguments: character),
        child: GridTile(
          child: Hero(
            tag: character!.charId as Object,
            child: Container(
              color: MyColors.myGrey,
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
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              '${character!.name}',
              style: TextStyle(
                  color: MyColors.mywhite,
                  fontSize: 16,
                  height: 1.3,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
