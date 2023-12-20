import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swe463_project/modules/register/cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clothing App"),
      ),
      body: BlocProvider(
          create: (_) => RegisterCubit(),
          child: BlocConsumer<RegisterCubit, RegisterStates>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = context.read<RegisterCubit>();
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Hero(
                        tag: "app_icon",
                        child: const Image(
                          image: AssetImage("assets/pictures/app_logo.png"),
                          height: 100,
                        ),
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                          labelText: "Name",
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: cubit.selectedGender,
                              onChanged: (value) {
                                cubit.setGender(value!);
                              },
                            ),
                            const Text("Male"),
                            const Spacer(),
                            Radio(
                              value: 1,
                              groupValue: cubit.selectedGender,
                              onChanged: (value) {
                                cubit.setGender(value!);
                              },
                            ),
                            const Text("Female"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email Address",
                          hintText: "example@abc.com",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "Please enter an email address";
                          }

                          final bool validInput =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);

                          if(validInput) {
                            return null;
                          }
                          else {
                            return "Please enter a valid email address";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Password",
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "Please enter a password";
                          }
                          else if(value.length < 6) {
                            return "Please enter a password of at least 6 characters";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Confirm Password",
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "Please confirm password";
                          }
                          else if(passwordController.text != value) {
                            return "Password not match";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        child: MaterialButton(
                          onPressed: () {
                            bool goodInput = formKey.currentState!.validate();

                            if(goodInput) {
                              cubit.registerUser(emailController.text, passwordController.text, nameController.text);
                            }
                          },
                          color: Colors.black,
                          child: const Text(
                            "REGISTER",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}