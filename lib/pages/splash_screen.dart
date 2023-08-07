import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_hostel_repo/pages/login_page.dart';
import 'package:vit_hostel_repo/pages/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getLoggedInStatus() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? loggedIn = prefs.getBool('loggedIn');
  print('gjnjbnfijb=====================');
  if(loggedIn == null || loggedIn == false){
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx) => LoginPage()));
  }
  else{
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MainPage()));
  }
}

  @override
  void initState() {
    
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    getLoggedInStatus();
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[200]
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xffF7F8FA),
            const Color(0xffDAE8F5).withOpacity(1),
            const Color(0xffDAE8F5).withOpacity(1),
            const Color(0xffDAE8F5).withOpacity(1),
            const Color(0xffDBE9F6).withOpacity(1),
          ],
          tileMode: TileMode.mirror,
        ),
              ),
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/VIT_Logo.png',width: 140,),
              SizedBox(
                height: 15,
              ),
              Text('Vellore Institute of Technology',style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 0, 99, 181),
              ),)
            ],
          ))
        ),
      ),
    );
  }
}