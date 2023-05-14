class EstadisticasUsuario {
  static const int tematicas = 6;
  String _quesitos;
  List<String> _preguntas, _incorrectas, _correctas, _aciertos;

  EstadisticasUsuario(this._quesitos, this._preguntas, this._incorrectas,
      this._correctas, this._aciertos);

  String getField(EstadisticasFieldsCodes r, TematicasEstadisticasCodes t) {
    switch (r) {
      case EstadisticasFieldsCodes.preguntas:
        return _preguntas[t.index];
      case EstadisticasFieldsCodes.incorrectas:
        return _incorrectas[t.index];
      case EstadisticasFieldsCodes.correctas:
        return _correctas[t.index];
      case EstadisticasFieldsCodes.acierto:
        return _aciertos[t.index];
    }
  }

  String getQuesitos() {
    return _quesitos;
  }

  setField(EstadisticasFieldsCodes r, TematicasEstadisticasCodes t, String s) {
    switch (r) {
      case EstadisticasFieldsCodes.preguntas:
        _preguntas[t.index] = s;
        break;
      case EstadisticasFieldsCodes.incorrectas:
        _incorrectas[t.index] = s;
        break;
      case EstadisticasFieldsCodes.correctas:
        _correctas[t.index] = s;
        break;
      case EstadisticasFieldsCodes.acierto:
        _aciertos[t.index] = s;
        break;
    }
  }
}

enum EstadisticasFieldsCodes {
  preguntas,
  incorrectas,
  correctas,
  acierto,
}

enum TematicasEstadisticasCodes {
  totales,
  geografia,
  ciencia,
  historia,
  entretenimiento,
  deportes,
  arte
}
