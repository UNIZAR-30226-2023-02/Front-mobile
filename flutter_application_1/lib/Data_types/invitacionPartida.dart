import 'dart:ffi';

class InvitacionPartida {
  String _nombreSala,
      _nombreAmigo;

  InvitacionPartida(
      {String nombreSala = "",
      String nombreAmigo = "",})
      : _nombreSala = nombreSala,
        _nombreAmigo = nombreAmigo;

  dynamic getField(InvitacionPartidaFieldsCodes r) {
    switch (r) {
      case InvitacionPartidaFieldsCodes.nombreSala:
        return _nombreSala;
      case InvitacionPartidaFieldsCodes.nombreAmigo:
        return _nombreAmigo;
    }
  }

  setField(InvitacionPartidaFieldsCodes r, dynamic s) {
    switch (r) {
      case InvitacionPartidaFieldsCodes.nombreSala:
        _nombreSala = s;
        break;
      case InvitacionPartidaFieldsCodes.nombreAmigo:
        _nombreAmigo = s;
        break;

    }
  }
}

enum InvitacionPartidaFieldsCodes {
  nombreSala,
  nombreAmigo
}
