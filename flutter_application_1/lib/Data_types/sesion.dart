class Sesion {
  String _usuario, _contrasena, _token;

  Sesion({
    String usuario = "",
    contrasena = "",
    token = "",
  })  : _usuario = usuario,
        _contrasena = contrasena,
        _token = token;

  String getField(SesionFieldsCodes r) {
    switch (r) {
      case SesionFieldsCodes.usuario:
        return _usuario;
      case SesionFieldsCodes.contrasena:
        return _contrasena;
      case SesionFieldsCodes.token:
        return _token;
    }
  }

  setField(SesionFieldsCodes r, String s) {
    switch (r) {
      case SesionFieldsCodes.usuario:
        _usuario = s;
        break;
      case SesionFieldsCodes.contrasena:
        _contrasena = s;
        break;
      case SesionFieldsCodes.token:
        _token = s;
        break;
    }
  }
}

enum SesionFieldsCodes {
  usuario,
  contrasena,
  token,
}
