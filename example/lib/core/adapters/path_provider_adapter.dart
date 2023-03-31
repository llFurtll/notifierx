import 'dart:io';

import 'package:example/core/utils/util.dart';
import 'package:path_provider/path_provider.dart';

abstract class PathProviderAdapter {
  Future<Directory?> getPath();
}

class PathProviderAdapterImpl extends PathProviderAdapter {
  @override
  Future<Directory?> getPath() async {
    final path = await getApplicationDocumentsDirectory();
    if (Util.isNull(path)) {
      return null;
    }

    return path;
  }
}