// Creating a Cubit
// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);
// }

// class CounterCubit extends Cubit<int> {
//   CounterCubit(int initialState) : super(initialState);
// }

// final cubitA = CounterCubit(0); // state starts at 0
// final cubitB = CounterCubit(10); // state starts at 10

// State Changes
// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);

//   void increment() => emit(state + 1);
// }

// Basic Usage
// void main() {
//   final cubit = CounterCubit();
//   print(cubit.state); // 0
//   cubit.increment();
//   print(cubit.state); // 1
//   cubit.close();
// }

// Stream Usage
// Future<void> main() async {
//   final cubit = CounterCubit();
//   final subscription = cubit.stream.listen(print); // 1
//   cubit.increment();
//   await Future.delayed(Duration.zero);
//   await subscription.cancel();
//   await cubit.close();
// }

// Observing a Cubit
// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);

//   void increment() => emit(state + 1);

//   @override
//   void onChange(Change<int> change) {
//     super.onChange(change);
//     print(change);
//   }
// }

// void main() {
//   CounterCubit()
//     ..increment()
//     ..close();
// }

// BlocObserver
// class SimpleBlocObserver extends BlocObserver {
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     print('${bloc.runtimeType} $change');
//   }
// }

// Error Handling
import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    addError(Exception('increment error!'), StackTrace.current);
    emit(state + 1);
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  CounterCubit()
    ..increment()
    ..close();
}
