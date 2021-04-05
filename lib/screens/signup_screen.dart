import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_login/providers/auth.dart';
import 'package:rest_api_login/screens/home_Screen.dart';
import 'package:rest_api_login/screens/login_Screen.dart';
import 'package:rest_api_login/utils/http_exception.dart';
import 'package:rest_api_login/widgets/topright_clippat.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {'email': '', 'password': ''};
  TextEditingController _passwordController = new TextEditingController();

  Future _submit() async {
    if (!_formKey.currentState.validate()) {
      //invalid
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false)
          .signUp(_authData['email'], _authData['password'])
          .then((_) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
        Navigator.of(context).pop();
      });
    } on HttpException catch (e) {
      var errorMessage = 'Authentication Failed';
      if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email is alredy exsist';
        _showerrorDialog(errorMessage);
      } else if (e.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Weak password';
        _showerrorDialog(errorMessage);
      }
    } catch (e) {
      var errorMessage = 'Please Try again later';
      _showerrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ClipPath(
                clipper: SimpleClipper(),
                child: Container(

                  height: 150,
                  width: 380,

                  decoration: BoxDecoration(
                    color: Colors.teal.shade300,

                  ),

                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('Create'
                          , style: TextStyle(
                            color: Colors.black,
                            fontSize: 18

                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(' Account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18

                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                //padding:
                //  EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            TextFormField(

                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: 'Enter Email ID',

                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),

                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),

                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: Colors.teal.shade300,
                                  )
                              ),
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Invalid email';
                                }
                              },
                              onSaved: (value) {
                                _authData['email'] = value;
                              },
                            ),

                            SizedBox(height: 5.0,),

                            IntlPhoneField(
                              decoration: InputDecoration(
                                labelText: 'Enter Phone Number',

                              ),
                              initialCountryCode: 'NP',
                              onChanged: (phone) {
                                print(phone.completeNumber);
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            TextFormField(
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                /* prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.black,
                                  )*/),
                              validator: (value) {
                                if (value.isEmpty || value.length < 5) {
                                  return 'Password is to Short';
                                }
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                            ),
                            TextFormField(
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                /* prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.black,
                                  )*/),
                              validator: (value) {
                                if (value.isEmpty || value.length < 5) {
                                  return 'Password is to Short';
                                }
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                            ),
                            Column(
                              children: [
                                Center(
                                  child: Row(
                                    children: [
                                      Text('     By continuing, you agree to our '),
                                      Text('Terms of',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),

                                Row(
                                  children: [
                                    Text('              Service ',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    Text('and '),
                                    Text('Privacy Policy',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ],
                                ),


                              ],
                            ),
                            SizedBox(height: 4.0,),
                         /*   InkWell(
                              onTap: () { *//* ... *//* },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('Forget Password ?', style: TextStyle(color: Colors.black)),
                                ),
                              ),
                            ),*/
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('Sign Up', style: TextStyle(color: Colors.black)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (ctx) => HomeScreen()));
                                    },
                                    color: Colors.teal.shade300,
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 30,
                                    ),
                                    padding: EdgeInsets.all(10),
                                    shape: CircleBorder(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4,),
                            Row(
                              children: [
                                Text("________"),
                                Text("           or Sign up with"),
                                Text("          __________"),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    color: Colors.white,

                                    textColor: Colors.redAccent,
                                    child:
                                    Image.network(
                                      'https://cdn1.iconfinder.com/data/icons/logos-brands-in-colors/544/Google__G__Logo-512.png',
                                      height: 40,
                                      width: 40,
                                    ),/*ImageIcon(
                                        AssetImage('<img src="https://img.icons8.com/color/48/000000/google-logo.png"/>'
                                        ),
                                      ),*/
                                    padding: EdgeInsets.all(5),
                                    shape: CircleBorder(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    color: Colors.white,

                                    //textColor: Colors.redAccent,
                                    child:
                                    Image.network(
                                      'https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/80-facebook-512.png',
                                      height: 40,
                                      width: 40,
                                    ),/*ImageIcon(
                                        AssetImage('<img src="https://img.icons8.com/color/48/000000/google-logo.png"/>'
                                        ),
                                      ),*/
                                    padding: EdgeInsets.all(5),
                                    shape: CircleBorder(),
                                  ),
                                ),


                              ],
                            ),
                            SizedBox(height: 8,),
                            /*Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(' Already have an account ? ',
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (ctx) => SignUpScreen()));
                                  },

                                  child: Text('Sign in', style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold)
                                  ),

                                ),
                              ],

                            )*/
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Already have an account?',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        children: <TextSpan>[
                                          TextSpan(text: ' Sign in',
                                              style: TextStyle(
                                                  color: Colors.blueAccent, fontSize: 18),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (ctx) => LoginScreen()));
                                                  // navigate to desired screen
                                                }
                                          )
                                        ]
                                    ),
                                  ),
                                )
                            )

                          ],
                        ),

                        /*     Container(
                              padding: EdgeInsets.only(top: 40),
                              width: 140,
                              child: RaisedButton(
                                  onPressed: () {
                                    _submit();
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  color: Colors.green),
                            ),*/
                        /*    Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => SignUpScreen()));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 90),
                                  child: Text(
                                    "Create Account",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            )*/

                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),

        /*child: Container(

          child: Stack(
            children: <Widget>[
              Container(
               height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width * 0.85,

              ),
              Container(
                padding:
                    EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sign up with username or email",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Username or Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  )),
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Invalid email';
                                }
                              },
                              onSaved: (value) {
                                _authData['email'] = value;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.black,
                                  )),
                              validator: (value) {
                                if (value.isEmpty || value.length < 5) {
                                  return 'Password is to Short';
                                }
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Confirm Password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            TextFormField(
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.black,
                                  )),
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Password doesnot match';
                                }
                              },
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 40),
                              width: 140,
                              child: RaisedButton(
                                  onPressed: () {
                                    _submit();
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  color: Colors.green),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => LoginScreen()));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 90),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),*/

      ),
    );
  }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An Error Occurs',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
