import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_purple_ventures/blocs/base/base_bloc_status.dart';
import 'package:test_purple_ventures/blocs/main/main_event.dart';
import 'package:test_purple_ventures/blocs/main/main_state.dart';
import 'package:test_purple_ventures/values/app_constant.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(): super(MainStateInitial()) {
    on<GetTodoListEvent>(_mapEventGetTodoListData);
  }

  void _mapEventGetTodoListData(GetTodoListEvent event, Emitter<MainState> emit) async {
    emit(await _willGetTodoListData(event.offset, event.status));
  }

  Future<MainState> _willGetTodoListData(int offset, String status) =>
      AppDependency.instance.baseRepository.getTodoList(
        offset: offset,
        limit: 10,
        isAsc: true,
        sortBy: AppConstant.CREATED_AT,
        status: status
      )!.then((networkResponse) {
        final value = networkResponse.response;
        return state.copyWith(
          status: networkResponse.status,
          taskResponse: value,
        );
  }).onError((error, _) => state.copyWith(status: StateFail(errorMessage: error.toString())));

}