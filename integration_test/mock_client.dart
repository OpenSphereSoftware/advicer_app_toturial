import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

enum GetResponseMode {
  advice,
  failure,
}

class MockClient extends Mock implements http.Client {
  GetResponseMode responsefromget = GetResponseMode.advice;

  set response(GetResponseMode resp) {
    responsefromget = resp;
  }



  @override
  Future<Response> get(Uri? url, {Map<String, String>? headers}) {
    switch (responsefromget) {
      case GetResponseMode.advice:
        return Future.value(
            Response('{"slip": { "id": 100, "advice": "Test Advice"}}', 200));

      case GetResponseMode.failure:
        return Future.value(
            Response('{"slip": { "id": 404, "advice": "Call Failed"}}', 404));
      default:
        return Future.value(
            Response('{"slip": { "id": 404, "advice": "Call Failed"}}', 404));
    }
  }
}
