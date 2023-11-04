import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grpc_poc/presentation/user/controllers/create_user.dart';

import '../state/create_user.dart';
import '../widgets/cache_user_card.dart';
import '../widgets/created_user_card.dart';
import '../widgets/user_card_display.dart';
import '../widgets/user_form.dart';

class CreateUserServerStreamScreen extends StatefulWidget {
  final CreateUserController _controller;

  const CreateUserServerStreamScreen(this._controller, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateUserServerStreamState();
  }
}

class _CreateUserServerStreamState extends State<CreateUserServerStreamScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CreateUserState _state = CreateUserState();
  List<CreateUserState> _usersPendingCreation = List.empty(growable: true);
  final List<CreatedUsersResponse> _savedUsers = List.empty(growable: true);

  List<CacheUserCard> buildCachedCardList() {
    List<CacheUserCard> cards = List.empty(growable: true);
    for (CreateUserState u in _usersPendingCreation) {
      cards.add(CacheUserCard(
        u.username ?? "",
        u.firstName ?? "",
        u.lastName ?? "",
        u.email ?? "",
        u.phone ?? "",
        u.birthDate.toString(),
        u.country ?? "",
        u.city ?? "",
        u.state ?? "",
        u.address ?? "",
        u.postalCode ?? "",
      ));
    }
    return cards;
  }

  List<CreatedUserCard> buildSavedUserCardList() {
    List<CreatedUserCard> cards = List.empty(growable: true);
    for (CreatedUsersResponse u in _savedUsers) {
      cards.add(CreatedUserCard(u.id ?? -1, u.username ?? ""));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Server Stream Demo",
          style: TextStyle(fontSize: 24.0),
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
            onCountryChanged: (v) {
              setState(() {
                _state.country = v;
              });
            },
            onCityChanged: (v) {
              setState(() {
                _state.city = v;
              });
            },
            onStateChanged: (v) {
              setState(() {
                _state.state = v;
              });
            },
            onAddressChanged: (v) {
              setState(() {
                _state.address = v;
              });
            },
            onPostalCodeChanged: (v) {
              setState(() {
                _state.postalCode = v;
              });
            },
            onRandomBtnPressed: () {
              var rng = Random();
              _state.username = "u${rng.nextInt(10000)}";
              _state.firstName = "fn${rng.nextInt(10000)}";
              _state.lastName = "ln${rng.nextInt(10000)}";
              _state.email = "e${rng.nextInt(10000)}@email.com";
              _state.phone = "+3466${rng.nextInt(9)}112233";
              _state.birthDate = DateTime.now();
              _state.country = "co ${rng.nextInt(10000)}";
              _state.city = "ci ${rng.nextInt(10000)}";
              _state.state = "st ${rng.nextInt(10000)}";
              _state.address = "ad ${rng.nextInt(10000)}";
              _state.postalCode = "po ${rng.nextInt(10000)}";
              setState(() {
                _usersPendingCreation.add(_state);
                _state = CreateUserState();
                _formKey.currentState?.reset();
              });
            },
            onCacheUserPressed: () {
              setState(() {
                _usersPendingCreation.add(_state);
                _state = CreateUserState();
                _formKey.currentState?.reset();
              });
            },
            onServerStorePressed: () async {
              await for (var u in widget._controller
                  .createUsersServerStream(request: _usersPendingCreation)) {
                setState(() {
                  _savedUsers.add(u);
                });
              }
              _usersPendingCreation = List.empty(growable: true);
            }),
      ],
    );
  }
}
