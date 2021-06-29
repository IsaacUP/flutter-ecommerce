import 'package:flutter/material.dart';
import 'package:app_test/src/login.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  final HttpLink httpLink = HttpLink(
    uri: 'https://flutter-ec.herokuapp.com/',
  );
  

  @override
  Widget build(BuildContext context) {


  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    ),
  );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
      title: 'U P W I N D',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginPage(),
    ),
    );
  }
}
