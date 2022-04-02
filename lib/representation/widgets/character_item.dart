import 'dart:ffi';

import "package:flutter/material.dart";
import 'package:my_flutter_block_mohammady/constants/my_colors.dart';
import 'package:my_flutter_block_mohammady/constants/strings.dart';
import 'package:my_flutter_block_mohammady/data/models/character.dart';

class CaracterItem extends StatelessWidget {
  final Character character;

  CaracterItem(@required this.character, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
          color: MyColors.myWhite, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap:()=> Navigator.pushNamed(context, characterDetailsScreen,arguments: character),

        child: GridTile(
          child: Hero(
            tag: character.charId!,
            child: Container(
              width: double.infinity,
              color: MyColors.myGrey,
             child: character.img!.isNotEmpty
                                ? FadeInImage.assetNetwork(
                                    width: double.infinity,
                                    height: double.infinity,
                                    placeholder: 'assets/images/loading.gif',
                                    image: character.img!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset('assets/images/placeholder.jpg'),

            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.bottomCenter,
            color: Colors.black54,
            child: Text(
              '${character.name}',
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
