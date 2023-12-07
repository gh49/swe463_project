import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swe463_project/modules/register/cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        labelText: "Name",
                      ),
                      keyboardType: TextInputType.text,
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email Address",
                        hintText: "example@abc.com",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
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
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      child: MaterialButton(
                        onPressed: () {

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
              );
            },
          )),
    );
  }
}
