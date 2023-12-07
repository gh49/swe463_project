import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clothing App"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Image(
              image: AssetImage("assets/pictures/app_logo.png"),
              height: 200,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
                labelText: "Email Address",
                hintText: "example@abc.com",
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.visibility),
                ),
                labelText: "Password",
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              child: MaterialButton(
                onPressed: () {
                  print("log in");
                },
                color: Colors.black,
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text("Don't have an account? "),
                TextButton(
                  onPressed: () {},
                  child: Text("Register now!"),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Divider()),
                SizedBox(
                  width: 5,
                ),
                Text("OR"),
                SizedBox(
                  width: 5,
                ),
                Expanded(child: Divider()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      print("sign in google");
                    },
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.g_mobiledata_sharp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "GOOGLE",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      print("sign in facebook");
                    },
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "FACEBOOK",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
