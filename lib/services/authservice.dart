import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AuthService {
  Dio dio = new Dio();

  login(name, password) async {
    try {
      return await dio.post('https://api-flutter-mdb.herokuapp.com/authenticate',
          data: {"name": name, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  addUser(name, password, domiciality, age) async {
    return await dio.post('https://api-flutter-mdb.herokuapp.com/adduser',
        data: {"name": name, "password": password, "domiciality": domiciality, "age": age},
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  setInfo(token, name, user) async {
    dio.options.headers['Authorization'] = 'Token $token';
    return await dio.post('http://34.239.109.204/api/v1/profile/profile_list/',
        data: {
          "name": name,
          "lastName": "default",
          "phone": "default",
          "address": "default",
          "user": user,
          "email": "default@default.com"
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  getInfo(token, id) async {
    dio.options.headers['Authorization'] = 'Token $token';
    return await dio
        .get('http://34.239.109.204/api/v1/profile/profile_detail/$id/');
  }

}
