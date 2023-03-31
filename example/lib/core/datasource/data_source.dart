import 'dart:io';

import 'package:example/core/adapters/path_provider_adapter.dart';

abstract class DataSource<T> {
  Future<T?> getDataSource();
}

class FileDataSource extends DataSource<File> {
  final PathProviderAdapter pathProvider;

  FileDataSource({
    required this.pathProvider
  });

  @override
  Future<File?> getDataSource() async {
    final dir = await pathProvider.getPath();
    if (dir == null) {
      return null;
    }

    final path = "${dir.path}/data.db";
    File file = File(path);
    if (!file.existsSync()) {
      file.createSync();
    }

    return file;
  }
}