import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageInitial());

  Future<void> changePage()async{
    emit(PageLoadingState());
   await Future.delayed(Duration(seconds: 3));
    emit(PageSuccessState());
  }
}
