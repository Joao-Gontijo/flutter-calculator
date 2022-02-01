//classe responsável por mostrar os dados no display
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Memory {
  static const operations = ['%', '/', 'x', '-', '+', '='];

  String _value = '0';
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String? _operation;
  bool _wipeValue = true;
  String? _lastCommand;

  String get value {
    return _value;
  }

  void applyCommand(String command) {
    if (_isReplacingOperation(command)) {
      _operation = command;
      return;
    }

    if (command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command); //valor sempre vai ter o valor novo
    }

    _lastCommand = command;
  }

  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand) &&
        operations.contains(command) &&
        _lastCommand != '=' &&
        command != '=';
  }

  _setOperation(String newOperation) {
    if (_bufferIndex == 0) {
      _operation = newOperation;
      _bufferIndex = 1;
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;

      bool isEqualSign = newOperation == '=';
      if (isEqualSign) {
        var __operation;
        _operation = __operation;
      } else {
        _operation = newOperation;
      }
      _bufferIndex = isEqualSign ? 0 : 1;
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
    _buffer.setAll(0, [0.0, 0.0]);
    var __operation;
    _operation = __operation;
    _wipeValue = false;
  }

  _calculate() {
    switch (_operation) {
      case '%':
        //   //x - y% == x - y
        return _buffer[0] * (_buffer[1] / 100);
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }
}
