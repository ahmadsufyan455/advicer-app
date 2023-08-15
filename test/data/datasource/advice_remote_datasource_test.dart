import 'package:advicer_app/data/datasource/remote_datasource.dart';
import 'package:advicer_app/data/exception/exception.dart';
import 'package:advicer_app/data/model/advice_model.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart';

import 'advice_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('AdviceRemoteDatasource', () {
    group('should return AdviceModel', () {
      test('when Client response was 200 and has valid data', () async {
        final mockClient = MockClient();
        final adviceRemoteDatasourceUnderTest =
            RemoteDataSourceImpl(client: mockClient);
        const responseBody = '{"advice": "test advice", "advice_id": 1}';

        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {
            'content-type': 'application/json',
          },
        )).thenAnswer(
            (realInvocation) => Future.value(Response(responseBody, 200)));

        // act
        final result =
            await adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi();

        // assert
        expect(result, AdviceModel(advice: 'test advice', id: 1));
      });
    });

    group('should throw', () {
      test('A ServerException when Client response was no 200', () {
        final mockClient = MockClient();
        final adviceRemoteDataSourceUnderTest =
            RemoteDataSourceImpl(client: mockClient);

        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {
            'content-type': 'application/json',
          },
        )).thenAnswer((realInvocation) => Future.value(Response('', 201)));

        expect(() => adviceRemoteDataSourceUnderTest.getRandomAdviceFromApi(),
            throwsA(isA<ServerException>()));
      });

      test('a Type Error when Client response was 200 and has no valid data',
          () {
        final mockClient = MockClient();
        final adviceRemoteDataSourceUnderTest =
            RemoteDataSourceImpl(client: mockClient);

        const responseBody = '{"advice": "test advice"}';

        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {
            'content-type': 'application/json',
          },
        )).thenAnswer(
            (realInvocation) => Future.value(Response(responseBody, 200)));

        expect(() => adviceRemoteDataSourceUnderTest.getRandomAdviceFromApi(),
            throwsA(isA<TypeError>()));
      });
    });
  });
}
