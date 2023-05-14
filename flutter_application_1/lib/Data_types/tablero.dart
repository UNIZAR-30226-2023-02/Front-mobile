class Tablero {
  String _imagen;
  int _id,_coste,_enUso,_adquirido;
  Tablero({
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

  dynamic getField(TableroFieldsCodes r) {
    switch (r) {
      case TableroFieldsCodes.id:
        return _id;
      case TableroFieldsCodes.coste:
        return _coste;
        case TableroFieldsCodes.enUso:
        return _enUso;
        case TableroFieldsCodes.adquirido:
        return _adquirido;
        case TableroFieldsCodes.imagen:
        return _imagen;
    }
  }

  setField(TableroFieldsCodes r, dynamic s) {
    switch (r) {
      case TableroFieldsCodes.id:
        _id = s;
        break;
      case TableroFieldsCodes.coste:
        _coste = s;
        break;
      case TableroFieldsCodes.enUso:
        _enUso = s;
        break;
      case TableroFieldsCodes.adquirido:
        _adquirido = s;
        break;
      case TableroFieldsCodes.imagen:
        _imagen = s;
        break;
    }
  }
}


enum TableroFieldsCodes {
  id,
  coste,
  enUso,
  adquirido,
  imagen
}
