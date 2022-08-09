class Profile {

  Profile(this.userId,this.email,this.name);

  String userId = "", email = "",  name = "";
  String food = "", animal = "";
  //List<PreferEvent> list = [];

  void setId(String userId) {
    this.userId = userId;
  }

  String getId() {
    return userId;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getEmail() {
    return email;
  }

  void setName(String name) {
    this.name = name;
  }

  String getName() {
    return name;
  }

  void setFood(String food) {
    this.food = food;
  }

  String getFood() {
    return food;
  }

  void setAnimal(String animal) {
    this.animal = animal;
  }

  String getAnimal() {
    return animal;
  }

/*
  void addEvent(PreferEvent event) {
    
  }

  void removeEvent(String evtname) {
    list.removeWhere((item) => item.name == evtname);
  }

  PreferEvent getEvent(String evtname) {
    var evt = list.firstWhere((element) => element.name == evtname);
    return evt;
  }

  void editEvent(PreferEvent event) {
    removeEvent(event.name);
    addEvent(event);
  }
  */
}

/*
class PreferEvent {
  String name = "";
  bool like = true;
  String description = "";

  PreferEvent(this.name,this.like,this.description);
}
*/