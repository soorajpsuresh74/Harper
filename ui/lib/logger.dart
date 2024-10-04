import 'package:flutter/material.dart';

class Logger {
  Logger._();

  static final Logger _instance = Logger._();

  factory Logger() {
    return _instance;
  }

  void info(String message) {
    _log('INFO', message);
  }

  void warning(String message) {
    _log('WARNING', message);
  }

  void error(String message) {
    _log('ERROR', message);
  }

  void _log(String level, String message) {
    final time = DateTime.now();
    print('[$time] $level: $message');
  }
}
