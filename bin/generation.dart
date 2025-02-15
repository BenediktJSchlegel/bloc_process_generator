import 'dart:io';

import 'package:path/path.dart' as p;

void generateFiles(
    String placeholder, String upperPlaceholder, String basePath) {
  final ph = placeholder.toLowerCase();
  final baseDir = Directory(basePath);

  if (!baseDir.existsSync()) {
    baseDir.createSync(recursive: true);
  }

  void createFile(String filePath, String content) {
    final file = File(filePath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync(content);
    }
  }

  final processDir = Directory(p.join(basePath, ph, 'process'));

  processDir.createSync(recursive: true);

  Directory(p.join(basePath, ph, 'process', 'io')).createSync(recursive: true);
  Directory(p.join(basePath, ph, 'process', 'navigation'))
      .createSync(recursive: true);
  Directory(p.join(basePath, ph, 'models')).createSync(recursive: true);
  Directory(p.join(basePath, ph, 'pages')).createSync(recursive: true);
  Directory(p.join(basePath, ph, 'widgets')).createSync(recursive: true);
  Directory(p.join(basePath, ph, 'bloc')).createSync(recursive: true);
  Directory(p.join(basePath, ph, 'bloc', 'state')).createSync(recursive: true);
  Directory(p.join(basePath, ph, 'bloc', 'event')).createSync(recursive: true);

  createFile(
    p.join(basePath, ph, 'process', '${ph}_process_controller.dart'),
    resolveTemplate(
      "ph_process_controller",
      placeholder,
      upperPlaceholder,
    ),
  );

  createFile(
    p.join(basePath, ph, 'process', 'io', '${ph}_input.dart'),
    resolveTemplate(
      "ph_input",
      placeholder,
      upperPlaceholder,
    ),
  );

  createFile(
    p.join(basePath, ph, 'process', 'io', '${ph}_output.dart'),
    resolveTemplate(
      "ph_output",
      placeholder,
      upperPlaceholder,
    ),
  );

  createFile(
    p.join(basePath, ph, 'process', 'navigation', '${ph}_navigator.dart'),
    resolveTemplate(
      "ph_navigator",
      placeholder,
      upperPlaceholder,
    ),
  );

  createFile(
    p.join(basePath, ph, 'pages', '${ph}_page.dart'),
    resolveTemplate(
      "ph_page",
      placeholder,
      upperPlaceholder,
    ),
  );

  createFile(
    p.join(basePath, ph, 'bloc', '${ph}_bloc.dart'),
    resolveTemplate(
      "ph_bloc",
      placeholder,
      upperPlaceholder,
    ),
  );

  createFile(
    p.join(basePath, ph, 'bloc', 'state', '${ph}_state.dart'),
    resolveTemplate(
      "ph_state",
      placeholder,
      upperPlaceholder,
    ),
  );

  createFile(
    p.join(basePath, ph, 'bloc', 'event', '${ph}_event.dart'),
    resolveTemplate(
      "ph_event",
      placeholder,
      upperPlaceholder,
    ),
  );

  print('Files generated successfully in $basePath');
}

String resolveTemplate(String name, String lowercase, String uppercase) {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final templatesDir = p.join(scriptDir.path, 'templates');
  final templateFile = File(p.join(templatesDir, '$name.template'));

  if (!templateFile.existsSync()) {
    throw Exception('Template file not found: $name');
  }

  var templateContent = templateFile.readAsStringSync();

  templateContent = templateContent.replaceAll("XXX", uppercase);
  templateContent = templateContent.replaceAll("{ph}", lowercase);

  return templateContent;
}

void run(String placeholder, String upperPlaceholder, String basePath) {
  generateFiles(placeholder, upperPlaceholder, basePath);
}
