import 'package:flutter/material.dart';
import 'package:app_test/src/FadeAnimation.dart';
import 'package:app_test/src/singup.dart';
import 'package:app_test/src/dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() {
    return new _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  var name, password, token, id, nameR;

  final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
  final minLetter = RegExp('[a-zA-Z]+');
  final space = RegExp('\s');
  final character = RegExp('[@!\$%&/?¡¿]+');

  final _text = TextEditingController();
  final _pass = TextEditingController();
  bool _validate = false;
  bool _validatePass = false;

  String errorPass = " ";
  String errorText = " ";

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background.png'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                  Positioned(
                    height: 400,
                    width: width + 20,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/bkg.png'),
                                  fit: BoxFit.fill)),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1.5,
                      Text(
                        "Iniciar sesión",
                        style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.7,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(196, 135, 198, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextField(
                                  controller: _text,
                                  maxLength: 30,
                                  decoration: InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: "Usuario",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      errorText: _validate ? errorText : null),
                                  onChanged: (val) {
                                    name = val;
                                  }),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                  controller: _pass,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Contraseña",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      errorText:
                                          _validatePass ? errorPass : null),
                                  onChanged: (val) {
                                    password = val;
                                  }),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  FadeAnimation(
                      1.9,
                      Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: RaisedButton(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            child: Center(
                              child: Text(
                                "iniciar sesión",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_text.text.isEmpty) {
                                  _validate = true;
                                  errorText = "vacio";
                                } else {
                                  if (_text.text.length >= 8 &&
                                      _text.text.length <= 30) {
                                    if (alphanumeric.hasMatch(_text.text)) {
                                      if (minLetter.hasMatch(_text.text)) {
                                        _validate = false;
                                      } else {
                                        // error minimo una letra
                                        _validate = true;
                                        errorText = "minimo una letra";
                                      }
                                    } else {
                                      // error no alfanumerico
                                      _validate = true;
                                      errorText = "no alfanumerico";
                                    }
                                  } else {
                                    //error minimo 8 caracteres
                                    _validate = true;
                                    errorText = "minimo 8 caracteres";
                                  }
                                }

                                if (_pass.text.isEmpty) {
                                  _validatePass = true;
                                  errorPass = "vacio";
                                } else {
                                  if (_pass.text.length >= 8 &&
                                      _pass.text.length <= 30) {
                                    if (minLetter.hasMatch(_pass.text)) {
                                      if (character.hasMatch(_pass.text)) {
                                        _validatePass = false;
                                      } else {
                                        _validatePass = true;
                                        errorPass =
                                            "minimo un caracter especial";
                                      }
                                    } else {
                                      _validatePass = true;
                                      errorPass = "minimo una letra";
                                    }
                                  } else {
                                    _validatePass = true;
                                    errorPass = "minimo 8 caracteres";
                                  }
                                }

                                if (_validate == false &&
                                    _validatePass == false) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DashboardPage()));
                                }
                              });

                              // showDialog(
                              //     context: context,
                              //     builder: (context) {
                              //       return AlertDialog(
                              //         content: Text(errorMensaje),
                              //       );
                              //     });

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => DashboardPage()));

                              /*AuthService().login(name, password).then((val) {
                                print(val.data['token']);
                                if (val.data['token'] != null) {
                                  token = val.data['token'];
                                  id = val.data['user_id'];

                                  AuthService().getInfo(token, id).then((req) {
                                    try {
                                      if (req.data[0]['id'] != null) {
                                        print("true");
                                      }
                                    } catch (e) {
                                      AuthService().setInfo(token, name, id);
                                    }
                                  });

                                  Fluttertoast.showToast(
                                      msg: 'Autenticación exitosa',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DashboardPage(
                                                id: id,
                                                token: token,
                                              )));
                                }
                              }); */
                            },
                          ))),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.7,
                      Center(
                          child: Text(
                        "O bien, puedes registrate",
                        style:
                            TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),
                      ))),
                  SizedBox(
                    height: 15,
                  ),
                  FadeAnimation(
                      2,
                      Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: RaisedButton(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            child: Center(
                              child: Text(
                                "Registrarme",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingupPage()));
                            },
                          ))),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
