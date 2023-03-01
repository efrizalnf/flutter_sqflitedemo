import 'package:flutter/material.dart';
import 'package:Sqflite_Demo/core.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  Widget build(BuildContext context, UserController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("SqfLite Demo"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: controller.getData(),
          builder: (context, snapshoot) {
            if (snapshoot.hasData) {
              return ListView.builder(
                itemCount: snapshoot.data?.length,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int i) {
                  // print(snapshoot.data?[i]);
                  return Dismissible(
                    key: Key("$snapshoot.data?[i]"),
                    onDismissed: (detail) {
                      controller.deleteUser(snapshoot.data?[i]['id']);
                    },
                    confirmDismiss: (direction) async {
                      bool confirm = false;
                      await showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text(
                                      'Are you sure you want to delete this item?'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[600],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                ),
                                onPressed: () {
                                  confirm = true;
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );
                      if (confirm) {
                        return Future.value(true);
                      }
                      return Future.value(false);
                    },
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InputView(
                                index: i,
                                value: snapshoot.data?[i],
                              ),
                            ),
                          ).then((value) => controller.getData());
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          backgroundImage: const NetworkImage(
                            "https://i.ibb.co/QrTHd59/woman.jpg",
                          ),
                        ),
                        title: Text("${snapshoot.data?[i]['name']}"),
                        subtitle: Text(
                            "Usia ${snapshoot.data?[i]['age'].toString()}"),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InputView(
                index: null,
                value: null,
              ),
            ),
          ).then((value) => controller.getData());
        },
      ),
    );
  }

  @override
  State<UserView> createState() => UserController();
}
