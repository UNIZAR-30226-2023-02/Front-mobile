import 'dart:ffi';

class InvitacionPartida {
  String _nombreSala, _nombreAmigo, _tipoPartida, _numeroJugadores, _webSocket;

  InvitacionPartida(
      {String nombreSala = "",
      String nombreAmigo = "",
      String tipoPartida = "",
      String numeroJugadores = "",
      String webSocket = ""})
      : _nombreSala = nombreSala,
        _nombreAmigo = nombreAmigo,
        _tipoPartida = tipoPartida,
        _numeroJugadores = numeroJugadores,
        _webSocket = webSocket;

  dynamic getField(InvitacionPartidaFieldsCodes r) {
    switch (r) {
      case InvitacionPartidaFieldsCodes.nombreSala:
        return _nombreSala;
      case InvitacionPartidaFieldsCodes.nombreAmigo:
        return _nombreAmigo;
      case InvitacionPartidaFieldsCodes.tipoPartida:
        return _tipoPartida;
      case InvitacionPartidaFieldsCodes.numeroJugadores:
        return _numeroJugadores;
      case InvitacionPartidaFieldsCodes.webSocket:
        return _webSocket;
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
      case InvitacionPartidaFieldsCodes.tipoPartida:
        _tipoPartida = s;
        break;
      case InvitacionPartidaFieldsCodes.numeroJugadores:
        _numeroJugadores = s;
        break;
      case InvitacionPartidaFieldsCodes.webSocket:
        _webSocket = s;
        break;
    }
  }
}

enum InvitacionPartidaFieldsCodes {
  nombreSala,
  nombreAmigo,
  tipoPartida,
  numeroJugadores,
  webSocket
}
