import 'dart:io';

import 'package:kp_directory/kp_directory.dart';
import 'package:test/test.dart';

void main() {
  group("makeEmptySync", () {
    test("it makes the directory empty", () {
      // make a tempdir
      final tempDir = Directory.systemTemp.createTempSync();

      // make sure it is empty
      expect(tempDir.listSync().isEmpty, isTrue);

      // populate it
      createFileSync(tempDir, 'file.txt');
      createDirSync(tempDir, 'my_dir_name');
      expect(tempDir.listSync().isEmpty, isFalse);

      makeEmptySync(tempDir);
      expect(tempDir.listSync().isEmpty, isTrue);
    });
  });
}
