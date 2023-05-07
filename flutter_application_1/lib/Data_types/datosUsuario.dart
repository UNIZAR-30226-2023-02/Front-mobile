import 'dart:ffi';

class DatosUsuario {
  String _usuario, _fecha, _correo, _telefono;

  DatosUsuario(
      {String usuario = "",
      String correoElectronico = "",
      String telefonoMovil = "",
      String fechaNacimiento = ""})
      : _usuario = usuario,
        _fecha = fechaNacimiento,
        _correo = correoElectronico,
        _telefono = telefonoMovil;

  dynamic getField(DatosUsuarioFieldsCodes r) {
    switch (r) {
      case DatosUsuarioFieldsCodes.usuario:
        return _usuario;
      case DatosUsuarioFieldsCodes.fechaNacimiento:
        return _fecha;
      case DatosUsuarioFieldsCodes.correoElectronico:
        return _correo;
      case DatosUsuarioFieldsCodes.telefonoMovil:
        return _telefono;
    }
  }

  setField(DatosUsuarioFieldsCodes r, dynamic s) {
    switch (r) {
      case DatosUsuarioFieldsCodes.usuario:
        _usuario = s;
        break;
      case DatosUsuarioFieldsCodes.fechaNacimiento:
        _fecha = s;
        break;
      case DatosUsuarioFieldsCodes.correoElectronico:
        _correo = s;
        break;
      case DatosUsuarioFieldsCodes.telefonoMovil:
        _telefono = s;
        break;
    }
  }
}

enum DatosUsuarioFieldsCodes {
  usuario,
  fechaNacimiento,
  correoElectronico,
  telefonoMovil,
}
