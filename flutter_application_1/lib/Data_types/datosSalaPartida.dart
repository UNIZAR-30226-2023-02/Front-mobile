import 'dart:ffi';

class DatosSalaPartida {
  String _nombre,
      _numeroJugadores,
      _tiempoRespuesta,
      _creador,
      _tipoPartida,
      _tipoSala;

  DatosSalaPartida(
      {String nombre = "",
      String numeroJugadores = "",
      String tiempoRespuesta = "",
      String creador = "",
      String tipoPartida = "",
      String tipoSala = ""})
      : _nombre = nombre,
        _numeroJugadores = numeroJugadores,
        _tiempoRespuesta = tiempoRespuesta,
        _creador = creador,
        _tipoPartida = tipoPartida,
        _tipoSala = tipoSala;

  dynamic getField(DatosSalaPartidaFieldsCodes r) {
    switch (r) {
      case DatosSalaPartidaFieldsCodes.nombre:
        return _nombre;
      case DatosSalaPartidaFieldsCodes.numeroJugadores:
        return _numeroJugadores;
      case DatosSalaPartidaFieldsCodes.tiempoRespuesta:
        return _tiempoRespuesta;
      case DatosSalaPartidaFieldsCodes.creador:
        return _creador;
      case DatosSalaPartidaFieldsCodes.tipoPartida:
        return _tipoPartida;
      case DatosSalaPartidaFieldsCodes.tipoSala:
        return _tipoSala;
    }
  }

  setField(DatosSalaPartidaFieldsCodes r, dynamic s) {
    switch (r) {
      case DatosSalaPartidaFieldsCodes.nombre:
        _nombre = s;
        break;
      case DatosSalaPartidaFieldsCodes.numeroJugadores:
        _numeroJugadores = s;
        break;
      case DatosSalaPartidaFieldsCodes.tiempoRespuesta:
        _tiempoRespuesta = s;
        break;
      case DatosSalaPartidaFieldsCodes.creador:
        _creador = s;
        break;
      case DatosSalaPartidaFieldsCodes.tipoPartida:
        _tipoPartida = s;
        break;
      case DatosSalaPartidaFieldsCodes.tipoSala:
        _tipoSala = s;
        break;
    }
  }
}

enum DatosSalaPartidaFieldsCodes {
  nombre,
  tiempoRespuesta,
  numeroJugadores,
  creador,
  tipoPartida,
  tipoSala
}

class DatosSalaPartidaClasica {
  String _nombre, _numeroJugadores, _tiempoRespuesta, _contrasena;

  DatosSalaPartidaClasica(
      {String nombre = "",
      String numeroJugadores = "",
      String tiempoRespuesta = "",
      String contrasena = ""})
      : _nombre = nombre,
        _numeroJugadores = numeroJugadores,
        _tiempoRespuesta = tiempoRespuesta,
        _contrasena = contrasena;

  dynamic getField(DatosSalaPartidaClasicaFieldsCodes r) {
    switch (r) {
      case DatosSalaPartidaClasicaFieldsCodes.nombre:
        return _nombre;
      case DatosSalaPartidaClasicaFieldsCodes.numeroJugadores:
        return _numeroJugadores;
      case DatosSalaPartidaClasicaFieldsCodes.tiempoRespuesta:
        return _tiempoRespuesta;
      case DatosSalaPartidaClasicaFieldsCodes.contrasena:
        return _contrasena;
    }
  }

  setField(DatosSalaPartidaClasicaFieldsCodes r, dynamic s) {
    switch (r) {
      case DatosSalaPartidaClasicaFieldsCodes.nombre:
        _nombre = s;
        break;
      case DatosSalaPartidaClasicaFieldsCodes.numeroJugadores:
        _numeroJugadores = s;
        break;
      case DatosSalaPartidaClasicaFieldsCodes.tiempoRespuesta:
        _tiempoRespuesta = s;
        break;
      case DatosSalaPartidaClasicaFieldsCodes.contrasena:
        _contrasena = s;
        break;
    }
  }
}

enum DatosSalaPartidaClasicaFieldsCodes {
  nombre,
  tiempoRespuesta,
  numeroJugadores,
  contrasena,
}
