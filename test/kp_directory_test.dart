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
    test("it does copy files", () {
      final fileInTempDir = getFile(tempDir, 'hello_world.txt')..createSync();

      final newDir = Directory.systemTemp.createTempSync();
      newDir.deleteSync(recursive: true);
      expect(newDir.existsSync(), isFalse);

      copySync(tempDir, newDir);

      expect(newDir.existsSync(), isTrue);

      expect(basename(newDir.listSync()[0].path), basename(fileInTempDir.path));
      newDir.deleteSync(recursive: true);
    });

    test("it does copy directories", () {
      final dirInTempDir = getDirectory(tempDir, 'hello_world.txt')
        ..createSync();

      final newDir = Directory.systemTemp.createTempSync();
      newDir.deleteSync(recursive: true);
      expect(newDir.existsSync(), isFalse);

      copySync(tempDir, newDir);

      expect(newDir.existsSync(), isTrue);

      expect(basename(newDir.listSync()[0].path), basename(dirInTempDir.path));
      newDir.deleteSync(recursive: true);
    });

    test("it does copy directories, files, links recursively ", () {
      getFile(tempDir, 'hello_world.txt')..createSync();

      final dirInTempDir = getDirectory(tempDir, 'hello_world')..createSync();

      getFile(dirInTempDir, "helo_world.txt")..createSync();
      getLink(dirInTempDir, "linktohello.txt")..createSync("helo_world.txt");
      // create a dir to remove again (for making a random name)
      final newDir = Directory.systemTemp.createTempSync();
      newDir.deleteSync(recursive: true);

      expect(newDir.existsSync(), isFalse);

      copySync(tempDir, newDir);

      expect(newDir.existsSync(), isTrue);

      expect(newDir.listSync(recursive: true).map((e) => basename(e.path)), [
        "hello_world",
        "helo_world.txt",
        "linktohello.txt",
        "hello_world.txt"
      ]);
      newDir.deleteSync(recursive: true);
    });
  });
}
