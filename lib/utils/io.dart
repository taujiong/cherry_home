import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getLocalFilePath(String module, String kind, String id) async {
  final docDir = await getApplicationDocumentsDirectory();
  return join(docDir.path, module, kind, id);
}
