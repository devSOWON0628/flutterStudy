import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn googleSignIn = GoogleSignIn();
class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}


class _LoginDemoState extends State<LoginDemo> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _success;
  String _userEmail;
  void showToast(String message){
    Fluttertoast.showToast(msg: message);
  }
  void _signInWithEmailAndPassword() async {
    final FirebaseUser user = (await auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )).user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
        showToast("로그인 되었심다ㅋ");
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => MyHomePage(title: "sowon Title" , age: "20",))
        );
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  void _loginGoogle() async{
    GoogleSignInAccount account = await googleSignIn.signIn();
    GoogleSignInAuthentication authentication = await account.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: authentication.idToken
        , accessToken: authentication.accessToken
    );
    AuthResult authResult = await auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;

    print("::"+user.uid);
    print("::"+user.displayName);
    print("::"+user.email);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.network('https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            FlatButton(
              onPressed: (){
                showToast("새로 회원가입 하슈 이미 계정은 날아갔음");
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                    _signInWithEmailAndPassword();

                  }else{
                    showToast("빈칸을 채워주세요");
                  }

                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: FloatingActionButton(
                  child: Icon(CupertinoIcons.sun_dust),
                  onPressed: ()=>{
                    _loginGoogle()
                  }
              ),
            ),
            InkWell(
              child: Text('New User? Create Account'),
              onTap: () => {
                Navigator.push(
                context, MaterialPageRoute(builder: (_) => RegisterEmailSection()))
              },
            )
          ],
        ),
      ),
    );
  }
}