// observer pattern
// when having an object that needs to be observed by one or more observers
// decoupling observable and observer
// used in mvc pattern

abstract class Observer {
  void update();
}

abstract class Subject {
  List<Observer> observers = [];
  void setState(String state);
  String getState();

  void attach(Observer value) {
    observers.add(value);
  }

  void detach(Observer value) {
    observers.remove(value);
  }

  void notifyObservers() {
    for (var element in observers) {
      element.update();
    }
  }
}

class ElliFeha extends Subject {
  final String state = 'silent';
  @override
  String getState() {
    return state;
  }

  @override
  void setState(String state) {
    state = state;
    notifyObservers();
  }
}

class Player extends Observer {
  final Subject subject;
  final String name;

  Player({required this.subject, required this.name}) {
    subject.attach(this);
  }

  void edrab() {
    subject.setState('ayyy!');
  }

  @override
  void update() {
    print('$name heard mohsen\'s Ayyy!');
  }
}

void sallahExample() {
  final Subject mohsen = ElliFeha();

  final Player mostafa = Player(subject: mohsen, name: 'Mostafa');
  final Player ahmed = Player(subject: mohsen, name: 'Ahmed');
  final Player ali = Player(subject: mohsen, name: 'Ali');
  mostafa.edrab();
  Future.delayed(Duration(seconds: 3));
  ahmed.edrab();
  Future.delayed(Duration(seconds: 3));
  ali.edrab();
}

void main() {
  sallahExample();
}
