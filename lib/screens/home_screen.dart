import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:weight_tracker/controllers/home_controller.dart';
import 'package:weight_tracker/controllers/connection_controller.dart';
import 'package:weight_tracker/services/auth.dart';
import 'package:weight_tracker/services/database.dart';
import 'package:weight_tracker/widgets/app_bar_icon_button.dart';
import 'package:weight_tracker/widgets/default_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _dbService = DatabaseService.dbService;
  final AuthService _authService = AuthService.authService;

  final HomeController _homeController = Get.find<HomeController>();
  final ConnectionController _connectionController =
    Get.find<ConnectionController>();

  final TextEditingController addWeightFieldController =
    TextEditingController();
  final TextEditingController editWeightFieldController =
    TextEditingController();

  String get connection => _connectionController.connection.value;
  set connection(String value) => _connectionController.connection.value = value;

  @override
  void initState() {

    _connectionController.connectionStreamSubscription =
      _connectionController.connectionStream.listen((result) {
        connection = result.name;

        Get.snackbar(
          'Connection status',
          'Connection: $connection',
          backgroundColor:Colors.orange,
          colorText: Colors.white,
          borderColor: Colors.white,
          borderWidth: 1.0,
          icon: Icon(
            _connectionController.setConnectionIcon(connection),
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
        );
      });

    super.initState();
  }

  @override
  void dispose() {
    addWeightFieldController.dispose();
    editWeightFieldController.dispose();
    _connectionController.connectionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference weights = _dbService.db.collection('weights');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarIconButton(
            icon: Icons.info_outline,
            pressed: () {
              Get.snackbar(
                'Tips',
                'Press entry to edit weight. \nLong press entry to delete weight.',
                backgroundColor:Colors.orange,
                colorText: Colors.white,
                borderColor: Colors.white,
                borderWidth: 1.0,
                icon: const Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                duration: const Duration(seconds: 5),
              );
            },
          ),
          actions: [
            AppBarIconButton(
              icon: Icons.logout,
              pressed: () async {
                await _authService.signOut();
              },
            )
          ],
        ),
        body: Obx(() {
          return (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder(
                stream:
                  weights.orderBy('timestamp', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView(children: [
                      ...snapshot.data.docs.map((weight) {
                        return Column(
                          children: [
                            ListTile(
                              title: Center(
                                child: Text(
                                  weight['weight'].toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 64.0,
                                  ),
                                ),
                              ),
                              minVerticalPadding: 10.0,
                              leading: Padding(
                                padding: const EdgeInsets.only(top: 22.0),
                                child: Text(DateFormat('dd.MM.yyyy | HH:mm ')
                                  .format(weight['timestamp'].toDate())
                                ),
                              ),
                              onTap: () async {
                                await Get.defaultDialog(
                                  title: 'Edit weight',
                                  content: DefaultTextField(
                                    fieldController: editWeightFieldController),
                                  textConfirm: 'Submit',
                                  confirmTextColor: Colors.white,
                                  onConfirm: () {
                                    _dbService.updateWeight(
                                      connection,
                                      weight,
                                      editWeightFieldController,
                                    );
                                    editWeightFieldController.clear();
                                  },
                                  textCancel: 'Cancel',
                                );
                              },
                              onLongPress: () {
                                _dbService.deleteWeight(
                                  connection,
                                  weight,
                                );
                              }
                            ),
                            const Divider(
                              thickness: 2.0,
                              indent: 20.0,
                              endIndent: 20.0,
                            ),
                          ],
                        );
                      }),
                    ]);
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error_outline);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            ),
            DefaultTextField(fieldController: addWeightFieldController),
            ElevatedButton(
              child: const Text(
                'Add weight',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'sans-serif-light'
                ),
              ),
              onPressed: _homeController.isAddButtonEnabled.value
                ? () async {
                  _homeController.isAddButtonEnabled.value = false;

                  await _dbService.addWeight(
                    connection,
                    weights,
                    addWeightFieldController,
                  );

                  _homeController.isAddButtonEnabled.value = true;
                }
                : null,
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200.0, 45.0),
                shape: const StadiumBorder(),
                side: const BorderSide(color: Colors.white),
                elevation: 5.0,
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ));
        },
      ))
    );
  }
}
