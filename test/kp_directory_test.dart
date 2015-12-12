import 'dart:io';

import 'package:kp_directory/kp_directory.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  group("makeEmptySync", () {
    test("it makes the directory empty", () {
      // make a tempdir
      final tempDir = Directory.systemTemp.createTempSync();

      // make sure it is empty
      expect(tempDir.listSync().isEmpty, isTrue);

      // populate it
      getFile(tempDir, 'file.txt')..createSync();
      getDirectory(tempDir, 'my_dir_name')..createSync();
      expect(tempDir.listSync().isEmpty, isFalse);

      makeEmptySync(tempDir);
      expect(tempDir.listSync().isEmpty, isTrue);
      tempDir.deleteSync(recursive: true);
    });
  });

  group("createFileSync", () {
    test("it creates a file", () {
      final tempDir = Directory.systemTemp.createTempSync();

      final file = getFile(tempDir, 'hello_world.txt')..createSync();
      expect(file.existsSync(), isTrue);
      tempDir.deleteSync(recursive: true);
    });
  });

  group("createDirSync", () {
    test("it creates a dir", () {
      final tempDir = Directory.systemTemp.createTempSync();

      final dir = getDirectory(tempDir, 'hello_world')..createSync();
      expect(dir.existsSync(), isTrue);
      tempDir.deleteSync(recursive: true);
    });
  });

  group("copySync", () {
    test("it does copy", () {
      final tempDir = Directory.systemTemp.createTempSync();
      final fileInTempDir = getFile(tempDir, 'hello_world.txt')..createSync();

      final newDir = Directory.systemTemp.createTempSync();
      newDir.deleteSync(recursive: true);
      expect(newDir.existsSync(), isFalse);

      copySync(tempDir, newDir);

      expect(newDir.existsSync(), isTrue);

      expect(basename(newDir.listSync()[0].path), basename(fileInTempDir.path));
      newDir.deleteSync(recursive: true);
      tempDir.deleteSync(recursive: true);
    });
  });
}
