part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class ChaactersError extends CharactersState{

}

class CharactersLoaded extends CharactersState{
  final List<Character> character;

  CharactersLoaded(this.character);
}

class QuotesLoaded extends CharactersState{
  final List<Quotes> quotes;

  QuotesLoaded(this.quotes);
}