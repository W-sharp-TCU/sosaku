enum CharacterNames { Ayana, Nonono, Neneka, Sakaki, Kawamoto, unknown }

/// key(enum):[[key(String), key(kanji), last name(kanji), last name(hiragana), firstName(kanji), firstname(hiragana)]]
const Map<CharacterNames, List<String>> _variations = {
  CharacterNames.Ayana: ['Ayana', '彩菜', '籾原', 'もみはら', '彩菜', 'あやな'],
  CharacterNames.Nonono: ['Nonono', 'ののの', '栃ノ瀬', 'とちのせ', 'ののの', 'ののの'],
  CharacterNames.Neneka: ['Neneka', '音々花', '庭', 'にわ', '音々花', 'ねねか'],
  CharacterNames.Sakaki: ['Sakaki', '榊', '銀田', 'ぎんだ', '榊', 'さかき'],
  CharacterNames.Kawamoto: ['Kawamoto', '川本', '川本', 'かわもと', '周', 'しゅう'],
  CharacterNames.unknown: ['unknown', '???', '???', '???', '???', '???'],
};

extension on CharacterNames {
  String get toStringEn => _variations[this]![0];
  String get toStringJa => _variations[this]![1];
  String get lastNameKanji => _variations[this]![2];
  String get lastNameHiragana => _variations[this]![3];
  String get firstNameKanji => _variations[this]![4];
  String get firstNameHiragana => _variations[this]![5];
}

extension on String {
  CharacterNames toCharacterNames() {
    CharacterNames formattedName = CharacterNames.unknown;
    for (CharacterNames name in CharacterNames.values) {
      if (_variations[name]!.contains(this)) {
        formattedName = name;
      }
    }
    return formattedName;
  }
}
