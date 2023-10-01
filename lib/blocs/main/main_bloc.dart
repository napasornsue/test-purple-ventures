import 'dart:io';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_purple_ventures/blocs/base/base_bloc_status.dart';
import 'package:test_purple_ventures/blocs/main/main_event.dart';
import 'package:test_purple_ventures/blocs/main/main_state.dart';
import 'package:test_purple_ventures/models/response/task/task.dart';
import 'package:test_purple_ventures/values/app_constant.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';

class MainBloc extends Bloc<MainEvent, MainState> {

  Map<String, List<Task>> groupedTasks = {};

  MainBloc(): super(MainStateInitial()) {
    on<GetTodoListEvent>(_mapEventGetTodoListData);
    on<LoadMoreTodoListEvent>(_mapEventLoadMoreTodoListData);
  }

  void _mapEventGetTodoListData(GetTodoListEvent event, Emitter<MainState> emit) async {
    emit(await _willGetTodoListData(event.offset, event.status));
  }

  void _mapEventLoadMoreTodoListData(LoadMoreTodoListEvent event, Emitter<MainState> emit) async {
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

  Map<String, List<Task>> groupItemsByDate(List<Task>? tasks) {
    if (tasks != null) {
      for (var task in tasks) {
        final dateString = task.createdAt;
        DateFormat dateFormat = DateFormat(AppConstant.DATETIME_DAY_OF_YEAR_PATTERN);
        DateTime? date = dateString != null ? DateTime.parse(dateString) : null;
        String displayDate = date != null ? dateFormat.format(date).toUpperCase() : "";
        int randomNumber = (Random().nextInt(9) + 1);
        task.image = "assets/images/task$randomNumber.png";

        if (!groupedTasks.containsKey(displayDate)) {
          groupedTasks[displayDate] = [];
        }
        groupedTasks[displayDate]!.add(task);
      }
    }
    return groupedTasks;
  }

  int calculateTotalTaskCount() {
    int totalTaskCount = 0;

    for (var tasks in groupedTasks.values) {
      totalTaskCount += tasks.length;
    }

    return totalTaskCount;
  }

}