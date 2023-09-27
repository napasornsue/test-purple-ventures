
import 'package:test_purple_ventures/blocs/base/base_bloc_status.dart';

class SplashState {
  final BaseBlocStatus status;

  SplashState({
    this.status = const BaseBlocStatusInit(),
  });

  SplashState copyWith({
    BaseBlocStatus? status,
  }) {
    return SplashState(
        status: status ?? this.status,
    );
  }
}

class SplashStateInitial extends SplashState {}