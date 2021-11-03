String enumToString(Object o) => o.toString().split('.').last;

Enum enumFromString<Enum>(List<Enum> enumValues, String key) => enumValues.firstWhere(
      (Enum element) => key.toLowerCase() == enumToString(element!).toLowerCase(),
    );
