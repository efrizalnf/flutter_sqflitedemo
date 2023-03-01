import 'package:flutter/material.dart';
import 'package:Sqflite_Demo/state_util.dart';
import '../../../persist/user_db.dart';
import '../view/user_view.dart';

class UserController extends State<UserView> implements MvcController {
  static late UserController instance;
  late UserView view;

  @override
  void initState() {
    instance = this;
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> getData() async {
    setState(() {});
    return await UserDB().db.then((value) => value.query('users'));
  }

  void deleteUser(int id) async {
    await UserDB().deleteUser(id);
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
