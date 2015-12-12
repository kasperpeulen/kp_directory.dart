import 'dart:io';

import 'package:path/path.dart';

void makeEmptySync(Directory dir) {
  dir.listSync().forEach((f) => f.deleteSync(recursive: true));
}

File getFile(Directory dir, String fileName) {
  return new File(join(dir.path, fileName));
}

Directory getDirectory(Directory dir, String directoryName) {
  return new Directory(join(dir.path, directoryName));
}

void copySync(Directory from, Directory to) {
  if (!to.existsSync()) to.createSync(recursive: true);

  // recursively copy all files and directories
  from.listSync().forEach((element) {
    String newPath = "${to.path}/${basename(element.path)}";
    if (element is File) {
      element.copy(newPath);
    } else if (element is Directory) {
      copySync(element, new Directory(newPath));
    } else if (element is Link) {
      throw new UnimplementedError(
          'Copying directories that contain Link objects '
          'is not implemented yet');
    }
  });
}
