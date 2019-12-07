import 'package:flutter/material.dart';
import 'package:story_reader/screens/successPage.dart';
import 'package:story_reader/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //space box
            Flexible(
              child: SizedBox(
                height: 100,
              ),
            ),

            //App Logo
            Flexible(
              flex: 2,
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(top: 40),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                  height: 200,
                ),
              ),
            ),

            //space box
            Flexible(
              child: SizedBox(
                height: 120,
              ),
            ),

            //Continue with google button
            GestureDetector(
              onTap: () {
                print("object");
              },
              child: Container(
                height: 1.2 * 39.00,
                width: 1.2 * 173.00,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border.all(
                    width: 1.00,
                    color: Color(0xff000000),
                  ),
                  borderRadius: BorderRadius.circular(2.00),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                      child: Image.asset(
                          'assets/images/authenticationScreen/googleLogo.png'),
                    ),
                    Text('Continue with Google', style: TextStyle(fontSize: 13))
                  ],
                ),
              ),
            ),

            //space box
            Flexible(
              child: SizedBox(
                height: 20,
              ),
            ),

            //continue with facebook button
            Container(
              height: 1.2 * 39.00,
              width: 1.2 * 173.00,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(
                  width: 1.00,
                  color: Color(0xff000000),
                ),
                borderRadius: BorderRadius.circular(2.00),
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Image.asset(
                        'assets/images/authenticationScreen/facebookLogo.png'),
                  ),
                  Text('Continue with Facebook', style: TextStyle(fontSize: 12))
                ],
              ),
            ),
            RaisedButton(
              child: Text("sign in with google"),
              onPressed: () {
                signInWithGoogle();
              },
            )
          ],
        ),
      ),
    );
  }
}
