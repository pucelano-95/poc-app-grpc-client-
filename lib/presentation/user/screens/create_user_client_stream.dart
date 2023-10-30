import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controllers/create_user.dart';
import '../state/create_user.dart';
import '../widgets/cache_user_card.dart';
import '../widgets/created_user_card.dart';
import '../widgets/user_card_display.dart';
import '../widgets/user_form.dart';

class CreateUserClientStreamScreen extends StatefulWidget {

  final CreateUserController _controller;

  const CreateUserClientStreamScreen(this._controller, {super.key, });

  @override
  State<StatefulWidget> createState() {
    return _CreateUserClientStreamState();
  }
}

class _CreateUserClientStreamState extends State<CreateUserClientStreamScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<CreatedUsersResponse> _savedUsers = List.empty(growable: true);
  List<CreateUserState> _cachedServerSentUsers = List.empty(growable: true);
  CreateUserState _state = CreateUserState();
  late StreamController<CreateUserState> _createUserStreamController;

  List<CreatedUserCard> buildSavedUserCardList() {
    List<CreatedUserCard> cards = List.empty(growable: true);
    for (CreatedUsersResponse u in _savedUsers) {
      cards.add(CreatedUserCard(u.id ?? -1, u.username ?? ""));
    }
    return cards;
  }

  @override
  void initState() {
    super.initState();
    initializeStream();
  }

  @override
  void dispose() {
    super.dispose();
    _createUserStreamController.close();
  }

  Future<void> initializeStream() async {
    _createUserStreamController = StreamController();
    var futureCreatedUsers = widget._controller.createUsersClientStream(
        requestStreamController: _createUserStreamController.stream);
    futureCreatedUsers.then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _savedUsers.addAll(value);
        });
      }
    });
  }

  List<CacheUserCard> buildCachedCardList() {
    List<CacheUserCard> cards = List.empty(growable: true);
    for (CreateUserState u in _cachedServerSentUsers) {
      cards.add(CacheUserCard(
          u.username ?? "",
          u.firstName ?? "",
          u.lastName ?? "",
          u.email ?? "",
          u.phone ?? "",
          u.birthDate.toString()));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
            "Client Stream Demo",
            style: TextStyle(
              fontSize: 24.0
            ),
        ),
        CardDisplay(title: "Cached users", userCards: buildCachedCardList()),
        CardDisplay(
            title: "Saved in server users",
            userCards: buildSavedUserCardList()),
        CreateUserForm(
            formKey: _formKey,
            onUsernameChanged: (v) {
              setState(() {
                _state.username = v;
              });
            },
            onFirstNameChanged: (v) {
              setState(() {
                _state.firstName = v;
              });
            },
            onLastNameChanged: (v) {
              setState(() {
                _state.lastName = v;
              });
            },
            onEmailChanged: (v) {
              setState(() {
                _state.email = v;
              });
            },
            onPhoneChanged: (v) {
              setState(() {
                _state.phone = v;
              });
            },
            onBirthDateChanged: (v) {
              setState(() {
                _state.birthDate = DateTime.tryParse(v);
              });
            },
            onRandomBtnPressed: () {
              var rng = Random();
              _state.username = "u ${rng.nextInt(10000)}";
              _state.firstName = "fn ${rng.nextInt(10000)}";
              _state.lastName = "ln ${rng.nextInt(10000)}";
              _state.email = "e${rng.nextInt(10000)}@email.com";
              _state.phone = "+3466${rng.nextInt(9)}112233";
              _state.birthDate = DateTime.now();
              _createUserStreamController.add(_state);
              setState(() {
                _cachedServerSentUsers.add(_state);
                _state = CreateUserState();
              });
            },
            onCacheUserPressed: () {
              _createUserStreamController.add(_state);
              setState(() {
                _cachedServerSentUsers.add(_state);
                _state = CreateUserState();
              });
            },
            onServerStorePressed: () async {
              _createUserStreamController.close();
              _cachedServerSentUsers = List.empty(growable: true);
              initializeStream();
            }
        ),
      ],
    );
  }
}
