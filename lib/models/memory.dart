//classe responsável por mostrar os dados no display
import 'package:flutter/foundation.dart';

class Memory {
  static const operations = const ['%', '/', 'x', '-', '+', '='];

  String _value = '0';
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  late String _operation;
  bool _wipeValue = true;

  String get value {
    return _value;
  }

  void applyCommand(String command) {
    if (command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command); //valor sempre vai ter o valor novo
    }
  }

  _setOperation(String newOperation) {
    if (_bufferIndex == 0) {
      _operation = newOperation;
      _bufferIndex = 1;
    }
    _wipeValue = true;
  }

  _addDigit(String digit) {
    final isDot = digit == '.';
    //condição para eliminar o zero a esquerda
    //se o valor for zero e o que foi digitado não é um ponto
    //ele vai sobrescrever o zero
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;

    //não permitir que existam dois pontos
    if (isDot && _value.contains('.') && !wipeValue) {
      return;
    } //gerou um bug excluindo o zero e deixando só o ponto

    final emptyValue = isDot ? '0' : ''; //só vai entrar caso for limpar a tela

    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    //jogar o valor obtido para o buffer
    _buffer[_bufferIndex] =
        double.tryParse(_value) ?? 0; //se não conseguir pegar o valor, coloca 0
    print(_buffer);
  }

  _allClear() {
    _value = '0';
  }
}
