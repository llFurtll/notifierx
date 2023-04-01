import 'core/adapters/path_provider_adapter.dart';
import 'core/datasource/data_source.dart';

List<dynamic> create() {
  List<dynamic> dependencies = [];

  dependencies.add(PathProviderAdapterImpl());
  dependencies.add(FileDataSource(pathProvider: dependencies.whereType().first));

  return dependencies;
}