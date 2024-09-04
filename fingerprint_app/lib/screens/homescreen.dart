import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthentic = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fingerprint App"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Account Balance",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
            ),
            _isAuthentic
                ? Text(
                    "25.45\$",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  )
                : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  15.0),
                    child: Text(
                        "Please, press the right bottom button to check the current balance account!",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                  ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
       if(!_isAuthentic){
       try{
         final bool authenticatewithBiometric = await _auth.canCheckBiometrics;
        if(authenticatewithBiometric){
          final bool didAuthentic = await _auth.authenticate(localizedReason: "Please verify your fingerprint to show your account balance",
          options: const AuthenticationOptions(
            biometricOnly: false,
          ),
          );
        setState(() {
          _isAuthentic = didAuthentic;
        });
        }
       }
       catch(e){
        print(e);
       }
       }else{
        setState(() {
          _isAuthentic = false;
        });
       }
      },child: _isAuthentic?Icon(Icons.lock_open): Icon(Icons.lock),),
    );
  }
}
