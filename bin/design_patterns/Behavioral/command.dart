/*
Command Design Pattern is a behavioral pattern that encapsulates a request as an object, decoupling the sender from the receiver.
It allows requests to be queued, logged, parameterized, or undone/redone, providing flexibility and extensibility in executing operations.
*/

// 3am Aly
class Receiver {
  final int id;

  Receiver({required this.id});
  num _money = 0;

  void sendMoney(num val) {
    _money = val;
    print("Receiver $id  total money = $_money");
  }
}

// osama
class Invoker {
  void execute(Command command) {
    command.execute();
  }
}

abstract class Command {
  void execute();
}

class SendMoneyCommand extends Command {
  final Receiver receiver;

  SendMoneyCommand({required this.receiver});
  @override
  void execute() {
    receiver.sendMoney(500);
  }
}

class SendMoneyToAllCommand extends Command {
  final List<Receiver> receivers;

  SendMoneyToAllCommand({required this.receivers});
  @override
  void execute() {
    for (var e in receivers) {
      e.sendMoney(500);
    }
  }
}

//3am Marwan (Sender)
void main() {
  final Invoker osama = Invoker();
  final Receiver amAly = Receiver(id: 0);
  final Command sendMoneyCommand = SendMoneyCommand(receiver: amAly);
  osama.execute(sendMoneyCommand);
  final Receiver amAhmed = Receiver(id: 1);
  final Receiver amMohamed = Receiver(id: 2);
  final Command sendMoneyToAllCommand = SendMoneyToAllCommand(
    receivers: [amAhmed, amMohamed],
  );
  osama.execute(sendMoneyToAllCommand);
}
