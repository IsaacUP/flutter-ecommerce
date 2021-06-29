import 'package:flutter/material.dart';
import 'package:app_test/src/FadeAnimation.dart';
import 'package:app_test/src/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app_test/services/authservice.dart';


class SingupPage extends StatelessWidget {
  var email, password, confirmPassword, username, cellphone;

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
                        "Registrarme",
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
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Ingresa tu username",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  onChanged: (val) {
                                    username = val;
                                  }),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Ingresa tu email",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  onChanged: (val) {
                                    email = val;
                                  }),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Ingresa tu no. de teléfono",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  onChanged: (val) {
                                    cellphone = val;
                                  }),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Ingresa tu contraseña",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  onChanged: (val) {
                                    password = val;
                                  }),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "Ingresa tu contraseña nuevamente",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  onChanged: (val) {
                                    confirmPassword = val;
                                  }),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.7,
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
                                "Registrarme",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              if (password != confirmPassword ||
                                  password.length < 5) {
                                Fluttertoast.showToast(
                                    msg:
                                        'Ups... Revisa tus datos, registro incorrecto',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {

                                  int access = 0;
                                  String registerUser = """
                                  mutation registerUser {
                                      createUser(input: {
                                        firstName: "$email", lastName: "$username", 
                                        userName: "$username", profilePic: "./", 
                                        email: "$email", phone: "$cellphone", 
                                        password: "$password"
                                    }) {
                                      _id
                                    }
                                  }
                                  """;

                                  AuthService()
                                    .addUser(email, password, username, cellphone)
                                    .then((val) {
                                  print(val.data['key']);
                                  Fluttertoast.showToast(
                                      msg: 'Registro exitoso, inicia sesión',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                });


                                /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                            Mutation(
                                              options: MutationOptions(
                                                documentNode: gql(registerUser), // this is the mutation string you just created
                                                // you can update the cache based on results
                                                update: (Cache cache, QueryResult result) {
                                                  return cache;
                                                },
                                                // or do something with the result.data on completion
                                                onCompleted: (dynamic resultData) {
                                                  print(resultData);
                                                  access++;
                                                  if (access == 1) {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => LoginPage()));
                                                  }
                                                },
                                              ),
                                              builder: (
                                                RunMutation runMutation,
                                                QueryResult result,
                                              ) {
                                                runMutation({
                                                    'starrableId': "<A_STARTABLE_REPOSITORY_ID>",
                                                });
                                                return Center(child: CircularProgressIndicator());
                                              },
                                            ))); */
                              }
                            },
                          ))),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.7,
                      Center(
                          child: Text(
                        "O bien, puedes iniciar sesión",
                        style:
                            TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),
                      ))),
                  SizedBox(
                    height: 15,
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
                            color: Color.fromRGBO(255, 255, 255, 1),
                            child: Center(
                              child: Text(
                                "Iniciar sesión",
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
                                      builder: (context) => LoginPage()));
                            },
                          ))),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
