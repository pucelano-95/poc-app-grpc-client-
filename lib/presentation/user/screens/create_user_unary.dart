import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grpc_poc/presentation/user/controllers/create_user.dart';
import 'package:flutter_grpc_poc/presentation/user/state/create_user.dart';
import 'package:flutter_grpc_poc/presentation/user/widgets/alert_text.dart';
import 'package:flutter_grpc_poc/presentation/user/widgets/user_form.dart';
import 'package:pluto_grid/pluto_grid.dart';

class CreateUserUnaryScreen extends StatefulWidget {
  final CreateUserController _controller;

  const CreateUserUnaryScreen(this._controller, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateUserUnaryState();
  }
}

class _CreateUserUnaryState extends State<CreateUserUnaryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CreateUserState _state = CreateUserState();
  List<CreateUserState> _usersPendingCreation = List.empty(growable: true);

  final List<PlutoColumn> columns = [];
  final List<PlutoRow> rows = [];
  late PlutoGridStateManager stateManager;

  int _timeDifference = 0;
  int _sizeOfDataSent = 0;

  @override
  void initState() {
    super.initState();

    columns.addAll([
      PlutoColumn(
          title: 'ID', field: 'id', type: PlutoColumnType.number(), width: 60),
      PlutoColumn(
          title: 'Username',
          field: 'username',
          type: PlutoColumnType.text(),
          width: 170),
      PlutoColumn(
          title: 'First Name',
          field: 'firstName',
          type: PlutoColumnType.text(),
          width: 120),
      PlutoColumn(
          title: 'Last Name',
          field: 'lastName',
          type: PlutoColumnType.text(),
          width: 120),
      PlutoColumn(
          title: 'Email',
          field: 'email',
          type: PlutoColumnType.text(),
          width: 160),
      PlutoColumn(
          title: 'Phone',
          field: 'phone',
          type: PlutoColumnType.text(),
          width: 130),
      PlutoColumn(
          title: 'Birth Date',
          field: 'birthDate',
          type: PlutoColumnType.date(),
          width: 110),
      PlutoColumn(
          title: 'Country',
          field: 'country',
          type: PlutoColumnType.text(),
          width: 70),
      PlutoColumn(
          title: 'City',
          field: 'city',
          type: PlutoColumnType.text(),
          width: 80),
      PlutoColumn(
          title: 'State',
          field: 'state',
          type: PlutoColumnType.text(),
          width: 80),
      PlutoColumn(
          title: 'Address',
          field: 'address',
          type: PlutoColumnType.text(),
          width: 110),
      PlutoColumn(
          title: 'Postal code',
          field: 'postalCode',
          type: PlutoColumnType.text(),
          width: 80),
    ]);

    fetchRows().then((fetchedRows) {
      PlutoGridStateManager.initializeRowsAsync(
        columns,
        fetchedRows,
      ).then((value) {
        stateManager.refRows.addAll(value);
        stateManager.setShowLoading(false);
      });
    });
  }

  Future<List<PlutoRow>> fetchRows() async {
    final response = await widget._controller.getAllUsersUnary();
    final fetchedRows = response.map<PlutoRow>((rowData) {
      return PlutoRow.fromJson(rowData.toJson());
    }).toList();
    return Future.value(fetchedRows);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Unary Demo",
          style: TextStyle(fontSize: 24.0),
        ),
        SizedBox(
          width: 2000.0, // Set a fixed width
          height: 500.0, // Set a fixed height
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager = event.stateManager;
                stateManager.setShowLoading(true);
              },
              configuration: const PlutoGridConfiguration(),
            ),
          ),
        ),
        CreateUserForm(
            formKey: _formKey,
            onServerStoreRandomData: () async {
              var rng = Random();
              _state.username = "someUsername${rng.nextInt(10000)}";
              _state.firstName = "firstName${rng.nextInt(10000)}";
              _state.lastName = "lastName${rng.nextInt(10000)}";
              _state.email = "user${rng.nextInt(10000)}@email.com";
              _state.phone = "+3466${rng.nextInt(9)}112233";
              _state.birthDate = DateTime.now();
              _state.country = "Spain";
              _state.city = "Madrid";
              _state.state = "Madrid";
              _state.address = "street${rng.nextInt(10000)}";
              _state.postalCode = "${10000 + rng.nextInt(99999 - 10000)}";
              _usersPendingCreation.add(_state);
              final startDateTime = DateTime.now();
              final createdUsers = await widget._controller
                  .createUserUnary(request: _usersPendingCreation);
              final endDateTime = DateTime.now();
              final fetchedRows = createdUsers.map<PlutoRow>((rowData) {
                return PlutoRow.fromJson(rowData.toJson());
              }).toList();
              stateManager.refRows.addAll(fetchedRows);
              stateManager.setShowLoading(false);
              setState(() {
                _state = CreateUserState();
                _formKey.currentState?.reset();
                _sizeOfDataSent = _usersPendingCreation.fold(
                    0,
                    (int size, userState) =>
                        size + userState.calculateSizeInBytes());
                _usersPendingCreation = List.empty(growable: true);
                _timeDifference = endDateTime.millisecondsSinceEpoch -
                    startDateTime.millisecondsSinceEpoch;
              });
            }),
        AlertTextField(
          title: 'Elapsed time for a GRPC unary call',
          content:
              'GRPC time in $_timeDifference ms for $_sizeOfDataSent bytes',
        ),
      ],
    );
  }
}
