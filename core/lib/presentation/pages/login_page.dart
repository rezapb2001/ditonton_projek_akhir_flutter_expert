import 'package:core/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatefulWidget {
  static const routeName = '/login';

  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  String _username = '';

  void _showalert() {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Hai $_username",
        style: const TextStyle(
          fontSize: 25,
        ),
      ),
      content: const Text(
        " Selamat datang kembali, Semoga harimu menyenangkan, Selamat Menonton...",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, HomePage.routeName),
          child: const Text(
            'Ok',
            style: TextStyle(
              fontSize: 18,
              color: Colors.yellowAccent,
            ),
          ),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alert);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset('assets/login.png', width: 125, height: 125),
          Positioned(
            child: SizedBox(
              height: 250,
              width: double.maxFinite,
              child: Card(
                margin: const EdgeInsets.all(15.0),
                elevation: 5,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 15.0),
                      child: TextField(
                        decoration: const InputDecoration(
                            suffixIcon:
                            Icon(Icons.account_circle, color: Colors.yellow),
                            labelText: 'Username'),
                        onChanged: (String value) {
                          setState(() {
                            _username = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFFFEB4B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          _showalert();
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
