import 'package:Sqflite_Demo/module/users/controller/input_controller.dart';
import 'package:flutter/material.dart';

class InputView extends StatefulWidget {
  final int? index;
  final Map<String, dynamic>? value;

  const InputView({
    super.key,
    required this.index,
    required this.value,
  });

  Widget build(BuildContext context, InputController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: index == null
            ? const Text("Insert User")
            : const Text("Update User"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: controller.controllerTextFormName(
                    value == null ? '' : value!['name']),
                maxLength: 20,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  helperText: "What's your name?",
                ),
                onChanged: (value) {
                  controller.nama = value;
                },
              ),
              TextFormField(
                controller: controller.controllerTextFormAge(
                    value == null ? '' : "${value?['age'].toString()}"),
                keyboardType: TextInputType.number,
                maxLength: 20,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  helperText: "What's your age?",
                ),
                onChanged: (value) {
                  int? intValue = int.tryParse(value);
                  if (intValue != null) {
                    controller.age = intValue;
                  } else {}
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (value?['id'] == null) {
                    controller.saveData();
                  } else {
                    controller.updateData(value?['id']);
                  }
                },
                child: const Text(
                  "Tambahkan",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<InputView> createState() => InputController();
}
