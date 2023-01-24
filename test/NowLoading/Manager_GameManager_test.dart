import 'package:sosaku/NowLoading/Manager_GameManager.dart';
import 'package:test/test.dart';

void main() {
  test('GameManager test', () {
    GameManager()
        .notify(ScreenInfo.fromConversation(eventCode: 100, instructionNo: 1));
  });
}
