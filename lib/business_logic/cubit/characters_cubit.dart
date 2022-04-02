import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_flutter_block_mohammady/data/models/character.dart';
import 'package:my_flutter_block_mohammady/data/models/quotes.dart';
import 'package:my_flutter_block_mohammady/data/repository/characters_repository.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  List<Character> characters = [];

  final CharacterRepository characterRepository;
  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  List<Character> getAllCharaters(){
    characterRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
     this.characters=characters;

    });
    return characters;
  }


  void getQuotes(String chrName){
    characterRepository.getQuotes(chrName: chrName).then((quotes) {
      emit(QuotesLoaded(quotes));
      this.characters=characters;
    });
  }
}
