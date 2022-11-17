import 'package:flutter/material.dart';

enum ButtonState {
  enable,
  disable,
  loading,
}

class ButtonController extends ChangeNotifier {
  ButtonState _state;

  ButtonController({
    state = ButtonState.enable,
  }) : _state = state;

  set state(value) {
    _state = value;
    notifyListeners();
  }

  get state => _state;

  isState(ButtonState state) {
    return this.state == state;
  }
}

