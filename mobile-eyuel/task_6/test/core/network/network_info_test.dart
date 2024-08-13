import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/core/network/network_info.dart';

import '../../helper/test_helper.mocks.dart';

void main() async {
  MockInternetConnectionChecker mockInternetConnectionChecker =
      MockInternetConnectionChecker();
  NetworkInfoImpl networkInfoImpl =
      NetworkInfoImpl(internetConnectionChecker: mockInternetConnectionChecker);

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(
        internetConnectionChecker: mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to InternetConnectionChecker.hasConnection',
        () async {
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => Future(() => true));

      final result = await networkInfoImpl.isConnected;

      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
