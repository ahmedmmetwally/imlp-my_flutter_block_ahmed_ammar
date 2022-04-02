import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:my_flutter_block_mohammady/business_logic/cubit/characters_cubit.dart';
import 'package:my_flutter_block_mohammady/constants/my_colors.dart';
import 'package:my_flutter_block_mohammady/data/models/character.dart';
import 'package:my_flutter_block_mohammady/representation/widgets/character_item.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  List<Character>? _allCharacter;
  List<Character>? _searchedForCharacter;
  TextEditingController _secrchTextController=TextEditingController();
  bool _isSearching=false;
  Widget _buildSearchfield(){
    return TextField(
      controller: _secrchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: "Find a caracter...",
        hintStyle: TextStyle(color: MyColors.myGrey,fontSize:18),
          border: InputBorder.none,
      ),
      style:TextStyle(color: MyColors.myGrey,fontSize:18),
      onChanged:(searchedCharacter){
        searchedFunction(searchedCharacter);
      }
    );
}
  void searchedFunction(String searchedCharacter) {
    _searchedForCharacter=_allCharacter!.where((element) => element.name!.toLowerCase()
        .startsWith(searchedCharacter)).toList();
    setState(() {

    });
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(onPressed: () {_clearSearch();Navigator.pop(context);},
          icon: Icon(Icons.clear, color: MyColors.myGrey),
        ),
      ];
    } else {
      return [
        IconButton(onPressed: _startSearch, icon: Icon(Icons.search, color: MyColors.myGrey,)),
      ];
    }
  }
  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching
    ));
    setState(() {
      _isSearching=true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState((){
      _isSearching=false;
    });
  }
  void _clearSearch() {
   setState((){ _secrchTextController.clear();});
  }


  @override
  void initState() {
   BlocProvider.of<CharactersCubit>(context).getAllCharaters();
    // TODO: implement initState
    super.initState();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          if (state is CharactersLoaded) {
            _allCharacter = (state).character;
            return buildLoadedListWidgets();
          } else {
            return showLoadingIndecator();
          }
        });
  }

  Widget showLoadingIndecator() {
    return Center(child: CircularProgressIndicator(color: MyColors.myYellow,),);
  }


  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [buildCaractersList()],
        ),
      ),
    );
  }

  Widget buildCaractersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _secrchTextController.text.isEmpty?_allCharacter!.length:_searchedForCharacter?.length,
        itemBuilder: (context, index) => CaracterItem(_secrchTextController.text.isEmpty?_allCharacter![index]:_searchedForCharacter![index]));
  }

  Widget _buildAppBarTitle(){
    return Text(
      "Characters",
      style: TextStyle(color: MyColors.myGrey),
    );
  }
  Widget buildNoInternetWidget(){
    return Center(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(height: 20,),
          Text("Can\'t connect ..... check your internet",style: TextStyle(fontSize: 22,color: MyColors.myGrey),),
          Image.asset("assets/images/no_internet.png"),
        ],),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: _isSearching? BackButton(color: Colors.black,):Container(),
        title: _isSearching ? _buildSearchfield() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
      connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
    ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if(connected){
          return buildBlocWidget();
        }else{
          return buildNoInternetWidget();
        }
      },child: Center(child: CircularProgressIndicator(),),
      )

    );
  }

}





