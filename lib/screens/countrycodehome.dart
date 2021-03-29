/*
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Country Code"), //appbar title
        backgroundColor: Colors.redAccent, //appbar color
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(children: <Widget>[
            Container(
                child:IntlPhoneField(
                  decoration: InputDecoration( //decoration for Input Field
                    labelText: 'Enter Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: '+91', //default contry code, NP for Nepal
                  onChanged: (phone) {
                    //when phone number country code is changed
                    print(phone.completeNumber); //get complete number
                    print(phone.countryCode); // get country code only
                    print(phone.number); // only phone number
                  },
                )
            ),
            Container(
              margin: EdgeInsets.only(top:20), //make submit button 100% width
              child:SizedBox(
                width:double.infinity,
                child:RaisedButton(
                  onPressed: (){
                    //action for button
                  },
                  color: Colors.redAccent,
                  child: Text("Submit"),
                  colorBrightness: Brightness.dark,
                  //backgroud color is darker so its birghtness
                ),
              ),
            )
          ],)
      ),
    );
  }
}*/
