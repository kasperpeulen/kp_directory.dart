import 'dart:io';

import 'package:kp_directory/kp_directory.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  var tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync();
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  group("makeEmptySync", () {
    test("it makes the directory empty", () {
      // make sure it is empty
      expect(tempDir.listSync().isEmpty, isTrue);

      // populate it
      getFile(tempDir, 'file.txt')..createSync();
      getDirectory(tempDir, 'my_dir_name')..createSync();
      expect(tempDir.listSync().isEmpty, isFalse);

      makeEmptySync(tempDir);
      expect(tempDir.listSync().isEmpty, isTrue);
    });
  });

  group("createFileSync", () {
    test("it creates a file", () {
      final file = getFile(tempDir, 'hello_world.txt')..createSync();
      expect(file.existsSync(), isTrue);
    });
  });

  group("createDirSync", () {
    test("it creates a dir", () {
      final dir = getDirectory(tempDir, 'hello_world')..createSync();
      expect(dir.existsSync(), isTrue);
    });
  });

  group("copySync", () {
    test("it does copy", () {
      final fileInTempDir = getFile(tempDir, 'hello_world.txt')..createSync();

      final newDir = Directory.systemTemp.createTempSync();
      newDir.deleteSync(recursive: true);
      expect(newDir.existsSync(), isFalse);

      copySync(tempDir, newDir);

      expect(newDir.existsSync(), isTrue);

      expect(basename(newDir.listSync()[0].path), basename(fileInTempDir.path));
      newDir.deleteSync(recursive: true);
    });
  });
}
