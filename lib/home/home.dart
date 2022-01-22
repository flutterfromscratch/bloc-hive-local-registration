import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localregistration/services/authentication.dart';
import 'package:localregistration/services/todo.dart';
import 'package:localregistration/todos/todos.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to Todo App'),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context),
        )..add(RegisterServicesEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfulLoginState) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TodosPage(
                    username: state.username,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              return Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Username'),
                    controller: usernameField,
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordField,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => BlocProvider.of<HomeBloc>(context).add(
                      LoginEvent(usernameField.text, passwordField.text),
                    ),
                    child: Text('LOGIN'),
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
