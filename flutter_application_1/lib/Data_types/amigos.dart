import 'dart:ffi';

class Amigos {
  List<String> _amigos = List<String>.empty();
  Amigos(List<String> a)
      : _amigos = a;

  List<String> getAmigos() {
    return _amigos;
  }

  void setAmigos(List<String> a) {
    _amigos = a;
  }
}
