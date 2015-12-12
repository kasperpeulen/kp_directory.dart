import 'dart:io';

import 'package:kp_directory/kp_directory.dart' as dir_util;
import 'package:kp_directory/kp_link.dart' as link_util;
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  test("it does copy links", () {
    final tempDir = Directory.systemTemp.createTempSync('a');

    dir_util.getFile(tempDir, "hello_world.txt")..createSync();
    var link = dir_util.getLink(tempDir, "linktohello_world.txt")..createSync("hello_world.txt");

    var dirInTempDir = dir_util.getDirectory(tempDir, "newDir")..createSync();

    var copyToLink = dir_util.getLink(dirInTempDir, 'otherlinktohello_world.txt');
    var newLink = link_util.copySync(link, copyToLink);

    expect(newLink.targetSync(), link.targetSync());
    expect(basename(newLink.path), 'otherlinktohello_world.txt');
    tempDir.deleteSync(recursive: true);
  });
}