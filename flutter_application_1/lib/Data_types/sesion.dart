class Sesion {
  String _usuario, _token;

  Sesion({
    String usuario = "",
    token = "",
  })  : _usuario = usuario,
        _token = token;

  String getField(SesionFieldsCodes r) {
    switch (r) {
      case SesionFieldsCodes.usuario:
        return _usuario;
      case SesionFieldsCodes.token:
        return _token;
    }
  }

  setField(SesionFieldsCodes r, String s) {
    switch (r) {
      case SesionFieldsCodes.usuario:
        _usuario = s;
        break;
      case SesionFieldsCodes.token:
        _token = s;
        break;
    }
  }
}

enum SesionFieldsCodes {
  usuario,
  token,
}
