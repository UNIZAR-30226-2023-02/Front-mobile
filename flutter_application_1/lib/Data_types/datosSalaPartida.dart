import 'dart:ffi';

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
