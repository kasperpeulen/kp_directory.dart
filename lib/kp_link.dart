import 'dart:io';

void copySync(Link from, Link to) {
  to.createSync(from.targetSync());
}