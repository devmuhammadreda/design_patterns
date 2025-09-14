void main() {}

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
