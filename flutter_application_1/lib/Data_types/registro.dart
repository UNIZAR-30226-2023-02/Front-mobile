class Registro {
  String _usuario,
      _contrasena,
      _confirmarContrasena,
      _fechaNacimiento,
      _correoElectronico,
      _telefonoMovil;

  Registro(
      {String usuario = "",
      contrasena = "",
      confirmarContrasena = "",
      fechaNacimiento = "",
      correoElectronico = "",
      telefonoMovil = ""})
      : _usuario = usuario,
        _contrasena = contrasena,
        _confirmarContrasena = confirmarContrasena,
        _fechaNacimiento = fechaNacimiento,
        _correoElectronico = correoElectronico,
        _telefonoMovil = telefonoMovil;

  String getField(RegistroFieldsCodes r) {
    switch (r) {
      case RegistroFieldsCodes.usuario:
        return _usuario;
      case RegistroFieldsCodes.contrasena:
        return _contrasena;
      case RegistroFieldsCodes.confirmarContrasena:
        return _confirmarContrasena;
      case RegistroFieldsCodes.fechaNacimiento:
        return _fechaNacimiento;
      case RegistroFieldsCodes.correoElectronico:
        return _correoElectronico;
      case RegistroFieldsCodes.telefonoMovil:
        return _telefonoMovil;
    }
  }

  setField(RegistroFieldsCodes r, String s) {
    switch (r) {
      case RegistroFieldsCodes.usuario:
        _usuario = s;
        break;
      case RegistroFieldsCodes.contrasena:
        _contrasena = s;
        break;
      case RegistroFieldsCodes.confirmarContrasena:
        _confirmarContrasena = s;
        break;
      case RegistroFieldsCodes.fechaNacimiento:
        _fechaNacimiento = s;
        break;
      case RegistroFieldsCodes.correoElectronico:
        _correoElectronico = s;
        break;
      case RegistroFieldsCodes.telefonoMovil:
        _telefonoMovil = s;
        break;
    }
  }
}

enum RegistroFieldsCodes {
  usuario,
  contrasena,
  confirmarContrasena,
  fechaNacimiento,
  correoElectronico,
  telefonoMovil,
}
