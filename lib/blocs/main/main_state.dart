
import 'package:test_purple_ventures/blocs/base/base_bloc_status.dart';
import 'package:test_purple_ventures/models/response/task/task_response.dart';

class MainState {
  final BaseBlocStatus status;
  final TaskResponse? taskResponse;

  MainState({
    this.status = const BaseBlocStatusInit(),
    this.taskResponse
  });

  MainState copyWith({
    BaseBlocStatus? status,
    TaskResponse? taskResponse,
  }) {
    return MainState(
      status: status ?? this.status,
      taskResponse: taskResponse ?? this.taskResponse,
    );
  }
}

class MainStateInitial extends MainState {}