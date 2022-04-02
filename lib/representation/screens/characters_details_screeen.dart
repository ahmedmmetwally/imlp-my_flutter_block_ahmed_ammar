import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_block_mohammady/business_logic/cubit/characters_cubit.dart';
import 'package:my_flutter_block_mohammady/constants/my_colors.dart';
import 'package:my_flutter_block_mohammady/data/models/character.dart';

class CharactersDetailsScreen extends StatefulWidget{
  final Character character;
  const CharactersDetailsScreen({Key? key,required this.character}) : super(key: key);

  @override
  State<CharactersDetailsScreen> createState() => _CharactersDetailsScreenState();
}

class _CharactersDetailsScreenState extends State<CharactersDetailsScreen>  with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController!);
    animationController?.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController?.dispose();
    super.dispose();
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
        expandedHeight: 600,
        stretch: true,
        pinned: true,
        backgroundColor: MyColors.myGrey,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(widget.character.name!,
              style: TextStyle(color: MyColors.myWhite)),
          background: Image.network(widget.character.img!, fit: BoxFit.cover,),
        )
    );
  }

  Widget characterInfo({required String title, required var value}) {
    return RichText(maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(text: title,
            style: TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.myWhite),),
          TextSpan(text: value,
            style: TextStyle(fontSize: 16, color: MyColors.myWhite),),
        ]));
  }

  Widget buildDivider({required double endIndent}) {
    return Divider(height: 30,
      thickness: 3,
      endIndent: endIndent,
      color: MyColors.myYellow,);
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuotesOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuotesOrEmptySpace(state) {
    var quotes = state.quotes;
    if (quotes.length != 0) {
      int randomQuote = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 35,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: Colors.white,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuote].quote),
            ],
            // onTap: () {
            //   print("Tap Event");
            // },
          ),
        ),
      );
    }
    else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return Center(child: CircularProgressIndicator(color: MyColors.myYellow,),);
  }


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(widget.character.name!);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverList(delegate: SliverChildListDelegate([
            Container(margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo(title: "Job : ",
                      value: widget.character.occupation?.join(" / ")),
                  buildDivider(endIndent: 315),
                  characterInfo(title: "Appeared in : ",
                      value: widget.character.category),
                  buildDivider(endIndent: 250),
                  characterInfo(title: "Seasons : ",
                      value: widget.character.appearance?.join(" / ")),
                  buildDivider(endIndent: 300),
                  characterInfo(
                      title: "Status : ", value: widget.character.status),
                  buildDivider(endIndent: 200),
                  widget.character.betterCallSaulAppearance!.isEmpty
                      ? Container()
                      :
                  characterInfo(title: "Better call break season : ",
                      value: widget.character.betterCallSaulAppearance?.join(
                          " / ")),
                  widget.character.betterCallSaulAppearance!.isEmpty
                      ? Container()
                      :
                  buildDivider(endIndent: 200),
                  characterInfo(
                      title: "Actor/Actress : ", value: widget.character.name),
                  buildDivider(endIndent: 270),
                  SizedBox(height: 20),
                  BlocBuilder<CharactersCubit,CharactersState>(builder:(context,state){return checkIfQuotesAreLoaded(state);}),
                  FadeTransition(opacity: fadingAnimation!,
                    child: Text(
                      "Fruit Market this anather way using animation",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 300,),
                ],),

            ),

           // checkIfQuotesAreLoaded(),


          ]
          )
          )
        ],
      ),
    );
  }

}
