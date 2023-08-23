part of 'page_cubit.dart';

@immutable
abstract class PageState {}

class PageInitial extends PageState {}

class PageLoadingState extends PageState{}

class PageSuccessState extends PageState{}
