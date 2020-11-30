import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/core/services/firebase_auth_service/firebase_auth_services.dart';
import 'package:gimeal/ui/shared/styles.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController namaCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController hpCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      height: 1.5,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 10),
                child: Text(
                  'Buat akun anda',
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: size.height / 1.33,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text('Hello!', style: kTitleStyle),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: namaCont,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Nama'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailCont,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: hpCont,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'No. Hp'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passCont,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: size.width,
                          height: 45,
                          child: RaisedButton(
                            onPressed: () async{
                             if( _formKey.currentState.validate()){
                               print('object');
                               SignInSignUpResult result = await AuthService.signUp(emailCont.text, passCont.text, namaCont.text, hpCont.text);
                                if(result.user != null){
                                  Fluttertoast.showToast(msg: 'Register Success');
                                  Navigator.pushNamed(context, Routers.loginPage);
                                }else{
                                   Fluttertoast.showToast(msg: 'Register gagal, ${result.message}');
                                }
                              }else{
                                print(emailCont.text + passCont.text +namaCont.text +hpCont.text);
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: kSubtitleStyle.copyWith(color: Colors.white),
                            ),
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                       
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
