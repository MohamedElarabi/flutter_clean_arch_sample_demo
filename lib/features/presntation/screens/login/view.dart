import 'package:clean_arc_first/core/service/service_locator.dart';
import 'package:clean_arc_first/features/presntation/screens/home_screen/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/shared_widget/loading.dart';
import '../../controllers/login_bloc/bloc.dart';
import '../../controllers/login_bloc/event.dart';
import '../../controllers/login_bloc/state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = sl<LoginBloc>();
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: bloc.loginPrams.phone,
                decoration: InputDecoration(
                    labelText: "Enter Phone",
                    fillColor: Colors.white,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    )),
                validator: (s) {
                  if (s!.isEmpty) {
                    return "Phone is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Enter Password",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    )),
                controller: bloc.loginPrams.password,
                obscureText: true,
                validator: (s) {
                  if (s!.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state.requestState == GlobalState.isLoading) {
                    LoadingScreen.show(context, "Loading, please wait");
                  } else if (state.requestState == GlobalState.isError) {
                    LoadingScreen.hide(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.msg)));
                  } else if (state.requestState == GlobalState.isLoaded) {
                    LoadingScreen.hide(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Welcome ${state.user!.fullName} you are Login Now ")));
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () => form.currentState?.validate() == true
                          ? bloc.add(ClickLoginEvent())
                          : null,
                      child: const Text("Login"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
