//classe responsável por mostrar os dados no display
class Memory {
  String _value = '0';

  String get value {
    return _value;
  }

  void applyCommand(String command) {
    if (command == 'AC') {
      _allClear();
    } else {
      _value += command; //valor sempre vai ter o valor novo
    }
  }

  _allClear() {
    _value = '0';
  }
}
