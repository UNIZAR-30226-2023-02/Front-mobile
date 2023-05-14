class Ficha {
  String _imagen;
  int _id,_coste,_enUso,_adquirido;
  Ficha({
    int id = 0,
    int coste = 0,
    int enUso = 0,
    int adquirido = 0,
    String imagen = ""
  })  : _id = id,
        _coste = coste,
        _enUso = enUso,
        _adquirido = adquirido,
        _imagen = imagen;

  dynamic getField(FichaFieldsCodes r) {
    switch (r) {
      case FichaFieldsCodes.id:
        return _id;
      case FichaFieldsCodes.coste:
        return _coste;
        case FichaFieldsCodes.enUso:
        return _enUso;
        case FichaFieldsCodes.adquirido:
        return _adquirido;
        case FichaFieldsCodes.imagen:
        return _imagen;
    }
  }

  setField(FichaFieldsCodes r, dynamic s) {
    switch (r) {
      case FichaFieldsCodes.id:
        _id = s;
        break;
      case FichaFieldsCodes.coste:
        _coste = s;
        break;
      case FichaFieldsCodes.enUso:
        _enUso = s;
        break;
      case FichaFieldsCodes.adquirido:
        _adquirido = s;
        break;
      case FichaFieldsCodes.imagen:
        _imagen = s;
        break;
    }
  }
}


enum FichaFieldsCodes {
  id,
  coste,
  enUso,
  adquirido,
  imagen
}
