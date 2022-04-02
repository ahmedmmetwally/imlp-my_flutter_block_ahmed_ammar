import 'package:my_flutter_block_mohammady/data/models/character.dart';
import 'package:my_flutter_block_mohammady/data/models/quotes.dart';
import 'package:my_flutter_block_mohammady/data/web_services/character_web_services.dart';

class CharacterRepository{
  CharacterWebServieces characterWebServieces;

  CharacterRepository( this.characterWebServieces);

  Future<List<Character>> getAllCharacters() async{
   List<dynamic> allCharacters =await characterWebServieces.fetchAllCharacters();
   return allCharacters.map((m)=>Character.fromJson(m)).toList();

  }
  Future <List<Quotes>> getQuotes({required String chrName})async{
    List<dynamic> allQuotes=await characterWebServieces.fetchQuotes(chrName: chrName);
    return allQuotes.map((quote) => Quotes.fromJson(quote)).toList();
  }
}