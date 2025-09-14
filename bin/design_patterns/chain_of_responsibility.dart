//chain of responsibility (behavioral)
// 1- decouple between sender and receiver
// 2- sender doesn't have to know between receiver
enum RequestType { conference, purchase }

class Request {
  final RequestType type;
  final num amount;
  Request({required this.type, required this.amount});
}

abstract class Handler {
  Handler? nextHandler;

  void setNext(Handler handler) {
    nextHandler = handler;
  }

  void handleRequest(Request request);
}

class Director extends Handler {
  @override
  void handleRequest(Request request) {
    if (request.type == RequestType.conference) {
      print('director can approval conference');
    } else {
      nextHandler?.handleRequest(request);
    }
  }
}

class VP extends Handler {
  @override
  void handleRequest(Request request) {
    if (request.type == RequestType.purchase) {
      if (request.amount < 1500) {
        print('vp can approval budget < 1500');
      } else {
        nextHandler?.handleRequest(request);
      }
    } else {
      nextHandler?.handleRequest(request);
    }
  }
}

class CEO extends Handler {
  @override
  void handleRequest(Request request) {
    print('ceo can approval anything');
  }
}

void approvalExample() {
  final Handler mohamed = Director();
  final Handler ahmed = VP();
  final Handler marwan = CEO();
  mohamed.setNext(ahmed);
  ahmed.setNext(marwan);

  final Request request = Request(type: RequestType.conference, amount: 500);
  mohamed.handleRequest(request);

  final Request request2 = Request(type: RequestType.purchase, amount: 1000);
  mohamed.handleRequest(request2);

  final Request request3 = Request(type: RequestType.purchase, amount: 2000);
  mohamed.handleRequest(request3);
}

void main() {
  approvalExample();
}
