// Creating Bloc

// events
import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0);
// }

// State Changes
// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0) {
//     on<CounterIncrementPressed>((event, emit) {
//       // handle incoming `CounterIncrementPressed` event
//       emit(state + 1);
//     });
//   }
// }

// // Basic Usage
// Future<void> main() async {
//   final bloc = CounterBloc();
//   print(bloc.state); // 0
//   bloc.add(CounterIncrementPressed());
//   await Future.delayed(Duration.zero);
//   print(bloc.state); // 1
//   await bloc.close();
// }

// Stream Usage
// Future<void> main() async {
//   final bloc = CounterBloc();
//   final subscription = bloc.stream.listen(print); // 1
//   bloc.add(CounterIncrementPressed());
//   await Future.delayed(Duration.zero);
//   await subscription.cancel();
//   await bloc.close();
// }

// Observing a Bloc
// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0) {
//     on<CounterIncrementPressed>((event, emit) => emit(state + 1));
//   }

//   @override
//   void onChange(Change<int> change) {
//     super.onChange(change);
//     print(change);
//   }
// }

// transition
// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0) {
//     on<CounterIncrementPressed>((event, emit) => emit(state + 1));
//   }

//   @override
//   void onChange(Change<int> change) {
//     super.onChange(change);
//     print(change);
//   }

//   @override
//   void onTransition(Transition<CounterEvent, int> transition) {
//     super.onTransition(transition);
//     print(transition);
//   }
// }

// void main() {
//   CounterBloc()
//     ..add(CounterIncrementPressed())
//     ..close();
// }

// BlocObserver
// class SimpleBlocObserver extends BlocObserver {
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     print('${bloc.runtimeType} $change');
//   }

//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     print('${bloc.runtimeType} $transition');
//   }

//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     print('${bloc.runtimeType} $error $stackTrace');
//     super.onError(bloc, error, stackTrace);
//   }
// }

// onEvent override
// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0) {
//     on<CounterIncrementPressed>((event, emit) => emit(state + 1));
//   }

//   @override
//   void onEvent(CounterEvent event) {
//     super.onEvent(event);
//     print(event);
//   }

//   @override
//   void onChange(Change<int> change) {
//     super.onChange(change);
//     print(change);
//   }

//   @override
//   void onTransition(Transition<CounterEvent, int> transition) {
//     super.onTransition(transition);
//     print(transition);
//   }
// }

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }
}

// Error Handling
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) {
      addError(Exception('increment error!'), StackTrace.current);
      emit(state + 1);
    });
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  CounterBloc()
    ..add(CounterIncrementPressed())
    ..close();
}
