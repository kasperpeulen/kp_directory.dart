import 'dart:io';

Link copySync(Link from, Link to) {
  to.createSync(from.targetSync());
  return to;
}
