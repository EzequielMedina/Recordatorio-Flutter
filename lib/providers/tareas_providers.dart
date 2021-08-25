class TareasProviders{
  
  List<Map<String, dynamic>> _tareas = [];

  static final TareasProviders _instancia = TareasProviders._privado();
  
  TareasProviders._privado(){
    _tareas = [];
  }
  factory TareasProviders(){
    return _instancia;
  }

  List<Map<String, dynamic>> get tareas{
    return _tareas;
  }
  void agregarTarea(Map<String, dynamic> nuevaTarea){
    _tareas.add(nuevaTarea);
  }
  void editarTarea(Map<String, dynamic> modificadaTarea, Map<String, dynamic> anteriorTarea){
    for (var i = 0; i < _tareas.length; i++) {
      if(_tareas[i] == anteriorTarea){
        _tareas[i] = modificadaTarea;
        break;
      }
      
    }
  }

  void eliminarTarea(Map<String, dynamic> borrarTarea){
    _tareas.remove(borrarTarea);
  }
  void terminarTarea(Map<String, dynamic> actualTarea){
    for (var i = 0; i < _tareas.length; i++) {
      
      if(_tareas[i] == actualTarea){
        actualTarea['estado']=true;
        _tareas[i]=actualTarea;
        break;
      }
      
    }
  }

}