import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_login/providers/auth.dart';
import 'package:rest_api_login/screens/home_Screen.dart';
import 'package:rest_api_login/screens/signup_screen.dart';
import 'package:rest_api_login/utils/http_exception.dart';
import 'package:rest_api_login/widgets/wave_clip_path.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {'email': '', 'password': ''};

  Future _submit() async {
    if (!_formKey.currentState.validate()) {
      //invalid
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);
    } on HttpException catch (e) {
      var errorMessage = 'Authentication Failed';
      if (e.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Invalid email';
        _showerrorDialog(errorMessage);
      } else if (e.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'This email not found';
        _showerrorDialog(errorMessage);
      } else if (e.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid Password';
        _showerrorDialog(errorMessage);
      }
    } catch (error) {
      var errorMessage = 'Plaese try again later';
      _showerrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ClipPath(
                clipper: MyClipPath(),
                child: Container(

                  height: 300,
                  width: 500,
                  child: Center(
                    child: Text("MY|MARKET",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade300,

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
                    SizedBox(height: 4.0,),
                            InkWell(
                              onTap: () { /* ... */ },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('Forget Password ?', style: TextStyle(color: Colors.black)),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('Sign in', style: TextStyle(color: Colors.black)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: MaterialButton(
                                    onPressed: () {},
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
                              Text("__________"),
                              Text("          or Login with"),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(' Already have an account ? ',
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => SignUpScreen()));
                          },

                            child: Text('Sign UP', style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.bold)
                            ),

                        ),
                      ],

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
