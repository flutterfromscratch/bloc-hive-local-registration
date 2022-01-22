part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class LoadTodosEvent extends TodosEvent {
  final String username;

  LoadTodosEvent(this.username);

  @override
  // TODO: implement props
  List<Object?> get props => [username];
}
