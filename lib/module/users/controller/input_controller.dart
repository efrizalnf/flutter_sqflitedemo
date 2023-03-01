import 'package:Sqflite_Demo/module/users/view/input_view.dart';
import 'package:flutter/material.dart';
import 'package:Sqflite_Demo/state_util.dart';
import '../../../persist/user_db.dart';
import '../model/users_dataclass.dart';

class InputController extends State<InputView> implements MvcController {
  static late InputController instance;
  late InputView view;
  String? nama;
  int? age;
  late int? index;
  late Map<String, dynamic>? value;
  TextEditingController controllerTextFormName(String val) =>
      TextEditingController(text: val);
  TextEditingController controllerTextFormAge(String val) =>
      TextEditingController(text: val);

  @override
  void initState() {
    instance = this;
    nama = '';
    age = 0;
    super.initState();
  }

  void saveData() {
    if (nama != null && age != null && nama != '' && age != 0) {
      var dataModel = Users(id: null, name: nama ?? '', age: age ?? 0);
      UserDB().insertUser(dataModel);
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Tidak Boleh kosong!"),
          content: const Text("Silahkan isi form"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
              ),
            )
          ],
        ),
      );
    }
  }

  void updateData(int id) {
    if (nama != null && age != null && nama != '' && age != 0) {
      var dataModel = Users(id: id, name: nama ?? '', age: age ?? 0);
      UserDB().updateUser(dataModel);
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Tidak Boleh kosong!"),
          content: const Text("Silahkan isi form"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
              ),
            )
          ],
        ),
      );
    }
  }

  // @override
  // void dispose() {
  //   getData();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
