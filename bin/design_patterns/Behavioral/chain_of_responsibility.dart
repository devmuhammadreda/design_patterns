/*
Chain Of Responsibility (Behavioral)
The Chain of Responsibility design pattern is a behavioral pattern that allows an object to pass a request along a chain of potential handlers until it is handled by an appropriate object.
This pattern promotes loose coupling between the sender of a request and its receivers,
and it allows multiple objects to have a chance to handle the request without explicitly specifying the receiver.
Suppose you are an employee in a company now you give a request of some approval to your manager if they can approve it ,
then you can get response from them otherwise the request is passed to senior manager , if they can approve it ,
then you can get response otherwise it goes to next person or level , 
so here you as an employee is completely unaware of how your request is getting approved and how multiple people are handling your request ,
this is Chain Responsibility Pattern .
*/
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

// Example 2

class SupportRequest {
  final String type;
  SupportRequest(this.type);
}

abstract class SupportHandler {
  SupportHandler? next;

  void handle(SupportRequest request) {
    if (next != null) {
      next!.handle(request);
    } else {
      print("Request not handled: ${request.type}");
    }
  }
}

class BillingSupport extends SupportHandler {
  @override
  void handle(SupportRequest request) {
    if (request.type == "billing") {
      print("Billing team handled request");
    } else {
      super.handle(request);
    }
  }
}

class TechnicalSupport extends SupportHandler {
  @override
  void handle(SupportRequest request) {
    if (request.type == "technical") {
      print("Technical team handled request");
    } else {
      super.handle(request);
    }
  }
}

class GeneralSupport extends SupportHandler {
  @override
  void handle(SupportRequest request) {
    if (request.type == "general") {
      print("General support handled request");
    } else {
      super.handle(request);
    }
  }
}

void supportExample() {
  var supportChain = BillingSupport()
    ..next = TechnicalSupport()
    ..next!.next = GeneralSupport();

  supportChain.handle(SupportRequest("billing"));
  supportChain.handle(SupportRequest("technical"));
  supportChain.handle(SupportRequest("general"));
  supportChain.handle(SupportRequest("sales"));
}

void main() {
  approvalExample();
  supportExample();
}
