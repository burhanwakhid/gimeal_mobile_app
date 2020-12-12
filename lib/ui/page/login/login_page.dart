import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/core/services/firebase_auth_service/firebase_auth_services.dart';
import 'package:gimeal/ui/shared/styles.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _emailFN = FocusNode();
  final FocusNode _passwordFN = FocusNode();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ProgressHUD(
      child: Builder(
        builder: (context) {
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
                        'Sign In',
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
                        'Silahkan Login',
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
                        padding:
                            const EdgeInsets.only(top: 40, left: 30, right: 30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Text('Hello!', style: kTitleStyle),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                focusNode: _emailFN,
                                controller: emailCont,
                                onFieldSubmitted: (val) {
                                  _passwordFN.requestFocus();
                                },
                                keyboardType: TextInputType.emailAddress,
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
                                focusNode: _passwordFN,
                                controller: passCont,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Tidak boleh kosong';
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(labelText: 'Password'),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                width: size.width,
                                height: 45,
                                child: RaisedButton(
                                  onPressed: () async {
                                    final progress = ProgressHUD.of(context);
                                    this._emailFN.unfocus();
                                    this._passwordFN.unfocus();
                                    if (_formKey.currentState.validate()) {
                                      print('object');
                                      progress.show();
                                      AuthService.signIn(
                                              emailCont.text, passCont.text)
                                          .then((value) {
                                        Fluttertoast.showToast(
                                            msg: 'Login Success');
                                        progress.dismiss();
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Routers.homePage,
                                            (route) => false);
                                      }).catchError((onError) {
                                        progress.dismiss();
                                        Fluttertoast.showToast(
                                            msg: 'Login gagal, $onError');
                                      });
                                      // if (result.user != null) {
                                      //   Fluttertoast.showToast(
                                      //       msg: 'Login Success');
                                      //   progress.dismiss();
                                      //   Navigator.pushNamedAndRemoveUntil(
                                      //       context,
                                      //       Routers.homePage,
                                      //       (route) => false);
                                      // } else {
                                      //   progress.dismiss();
                                      //   Fluttertoast.showToast(
                                      //       msg:
                                      //           'Login gagal, ${result.message}');
                                      // }
                                    }
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: kSubtitleStyle.copyWith(
                                        color: Colors.white),
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
        },
      ),
    );
  }
}
