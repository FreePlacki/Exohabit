import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    lineLength: 80,
    noBoxingByDefault: true,
    printEmojis: false,
  ),
);
