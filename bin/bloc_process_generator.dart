import 'package:args/args.dart';

import 'generation.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addOption('location', abbr: 'l', help: 'where to put the files.')
    ..addOption('class', abbr: 'c', help: 'The class name.')
    ..addOption('placeholder', abbr: 'p', help: 'the lowercase placeholder.');
}

void printUsage(ArgParser argParser) {
  print('Usage: dart bloc_process_generator.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);

    final String location = results.option("location")!;
    final String placeholder = results.option("placeholder")!;
    final String upperPlaceholder = results.option("class")!;

    run(placeholder, upperPlaceholder, location);
  } on FormatException catch (e) {
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
