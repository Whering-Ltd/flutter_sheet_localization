import 'dart:ui';
import 'package:template_string/template_string.dart';
    
final localizedLabels = <Locale, Example>{
  Locale.fromSubtags(languageCode: 'fr'): const Example(
    multiline: 'C\'est\nune\nexemple multiligne.',
    dates: const ExampleDates(
      weekday: const ExampleDatesWeekday(
        monday: 'lundi',
        tuesday: 'mardi',
        wednesday: 'mercredi',
      ),
    ),
    templated: const ExampleTemplated(
      hello: 'Bonjour {{first_name}}!',
      contactMale: 'M. {{last_name}}',
      contactFemale: 'Mme. {{last_name}}',
      numbers: const ExampleTemplatedNumbers(
        count: 'Il y a {{count:int}} éléments.',
        simple: 'Le prix est de {{price:double}}€',
        formatted: 'Le prix est de {{price:double[compactCurrency]}}',
      ),
      date: const ExampleTemplatedDate(
        simple: 'Aujourd\'hui : {{date:DateTime}}',
        pattern: 'Aujourd\'hui : {{date:DateTime[EEE, M/d/y]}}',
      ),
    ),
    plurals: const ExamplePlurals(
      manZero: 'hommes',
      manOne: 'homme',
      manMultiple: 'hommes',
    ),
  ),
  Locale.fromSubtags(languageCode: 'en', countryCode: 'US'): const Example(
    multiline: '?',
    dates: const ExampleDates(
      weekday: const ExampleDatesWeekday(
        monday: '?',
        tuesday: '?',
        wednesday: '?',
      ),
    ),
    templated: const ExampleTemplated(
      hello: '?',
      contactMale: '?',
      contactFemale: '?',
      numbers: const ExampleTemplatedNumbers(
        count: '?',
        simple: '?',
        formatted: '?',
      ),
      date: const ExampleTemplatedDate(
        simple: '?',
        pattern: '?',
      ),
    ),
    plurals: const ExamplePlurals(
      manZero: '?',
      manOne: '?',
      manMultiple: '?',
    ),
  ),
};

enum Gender {
  male,
  female,
}

enum Plural {
  zero,
  one,
  multiple,
}

class Example {
  const Example({
    required this.multiline,
    required this.dates,
    required this.templated,
    required this.plurals,
  });

  final String multiline;
  final ExampleDates dates;
  final ExampleTemplated templated;
  final ExamplePlurals plurals;
  factory Example.fromJson(Map<String, Object?> map) => Example(
        multiline: map['multiline']! as String,
        dates: ExampleDates.fromJson(map['dates']! as Map<String, Object?>),
        templated: ExampleTemplated.fromJson(
            map['templated']! as Map<String, Object?>),
        plurals:
            ExamplePlurals.fromJson(map['plurals']! as Map<String, Object?>),
      );

  Example copyWith({
    String? multiline,
    ExampleDates? dates,
    ExampleTemplated? templated,
    ExamplePlurals? plurals,
  }) =>
      Example(
        multiline: multiline ?? this.multiline,
        dates: dates ?? this.dates,
        templated: templated ?? this.templated,
        plurals: plurals ?? this.plurals,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Example &&
          multiline == other.multiline &&
          dates == other.dates &&
          templated == other.templated &&
          plurals == other.plurals);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      multiline.hashCode ^
      dates.hashCode ^
      templated.hashCode ^
      plurals.hashCode;
}

class ExampleDates {
  const ExampleDates({
    required this.weekday,
  });

  final ExampleDatesWeekday weekday;
  factory ExampleDates.fromJson(Map<String, Object?> map) => ExampleDates(
        weekday: ExampleDatesWeekday.fromJson(
            map['weekday']! as Map<String, Object?>),
      );

  ExampleDates copyWith({
    ExampleDatesWeekday? weekday,
  }) =>
      ExampleDates(
        weekday: weekday ?? this.weekday,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleDates && weekday == other.weekday);
  @override
  int get hashCode => runtimeType.hashCode ^ weekday.hashCode;
}

class ExampleDatesWeekday {
  const ExampleDatesWeekday({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
  });

  final String monday;
  final String tuesday;
  final String wednesday;
  factory ExampleDatesWeekday.fromJson(Map<String, Object?> map) =>
      ExampleDatesWeekday(
        monday: map['monday']! as String,
        tuesday: map['tuesday']! as String,
        wednesday: map['wednesday']! as String,
      );

  ExampleDatesWeekday copyWith({
    String? monday,
    String? tuesday,
    String? wednesday,
  }) =>
      ExampleDatesWeekday(
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleDatesWeekday &&
          monday == other.monday &&
          tuesday == other.tuesday &&
          wednesday == other.wednesday);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      monday.hashCode ^
      tuesday.hashCode ^
      wednesday.hashCode;
}

class ExampleTemplated {
  const ExampleTemplated({
    required String hello,
    required String contactMale,
    required String contactFemale,
    required this.numbers,
    required this.date,
  })  : _hello = hello,
        _contactMale = contactMale,
        _contactFemale = contactFemale;

  final String _hello;
  final String _contactMale;
  final String _contactFemale;
  final ExampleTemplatedNumbers numbers;
  final ExampleTemplatedDate date;

  String hello({
    required String firstName,
    String? locale,
  }) {
    return _hello.insertTemplateValues(
      {
        'first_name': firstName,
      },
      locale: locale,
    );
  }

  String contact({
    required Gender gender,
    required String lastName,
    String? locale,
  }) {
    if (gender == Gender.male) {
      return _contactMale.insertTemplateValues(
        {
          'last_name': lastName,
        },
        locale: locale,
      );
    }
    if (gender == Gender.female) {
      return _contactFemale.insertTemplateValues(
        {
          'last_name': lastName,
        },
        locale: locale,
      );
    }
    throw Exception();
  }

  factory ExampleTemplated.fromJson(Map<String, Object?> map) =>
      ExampleTemplated(
        hello: map['hello']! as String,
        contactMale: map['contactMale']! as String,
        contactFemale: map['contactFemale']! as String,
        numbers: ExampleTemplatedNumbers.fromJson(
            map['numbers']! as Map<String, Object?>),
        date:
            ExampleTemplatedDate.fromJson(map['date']! as Map<String, Object?>),
      );

  ExampleTemplated copyWith({
    String? hello,
    String? contactMale,
    String? contactFemale,
    ExampleTemplatedNumbers? numbers,
    ExampleTemplatedDate? date,
  }) =>
      ExampleTemplated(
        hello: hello ?? _hello,
        contactMale: contactMale ?? _contactMale,
        contactFemale: contactFemale ?? _contactFemale,
        numbers: numbers ?? this.numbers,
        date: date ?? this.date,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleTemplated &&
          _hello == other._hello &&
          _contactMale == other._contactMale &&
          _contactFemale == other._contactFemale &&
          numbers == other.numbers &&
          date == other.date);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      _hello.hashCode ^
      _contactMale.hashCode ^
      _contactFemale.hashCode ^
      numbers.hashCode ^
      date.hashCode;
}

class ExampleTemplatedNumbers {
  const ExampleTemplatedNumbers({
    required String count,
    required String simple,
    required String formatted,
  })  : _count = count,
        _simple = simple,
        _formatted = formatted;

  final String _count;
  final String _simple;
  final String _formatted;

  String count({
    required int count,
    String? locale,
  }) {
    return _count.insertTemplateValues(
      {
        'count': count,
      },
      locale: locale,
    );
  }

  String simple({
    required double price,
    String? locale,
  }) {
    return _simple.insertTemplateValues(
      {
        'price': price,
      },
      locale: locale,
    );
  }

  String formatted({
    required double price,
    String? locale,
  }) {
    return _formatted.insertTemplateValues(
      {
        'price': price,
      },
      locale: locale,
    );
  }

  factory ExampleTemplatedNumbers.fromJson(Map<String, Object?> map) =>
      ExampleTemplatedNumbers(
        count: map['count']! as String,
        simple: map['simple']! as String,
        formatted: map['formatted']! as String,
      );

  ExampleTemplatedNumbers copyWith({
    String? count,
    String? simple,
    String? formatted,
  }) =>
      ExampleTemplatedNumbers(
        count: count ?? _count,
        simple: simple ?? _simple,
        formatted: formatted ?? _formatted,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleTemplatedNumbers &&
          _count == other._count &&
          _simple == other._simple &&
          _formatted == other._formatted);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      _count.hashCode ^
      _simple.hashCode ^
      _formatted.hashCode;
}

class ExampleTemplatedDate {
  const ExampleTemplatedDate({
    required String simple,
    required String pattern,
  })  : _simple = simple,
        _pattern = pattern;

  final String _simple;
  final String _pattern;

  String simple({
    required DateTime date,
    String? locale,
  }) {
    return _simple.insertTemplateValues(
      {
        'date': date,
      },
      locale: locale,
    );
  }

  String pattern({
    required DateTime date,
    String? locale,
  }) {
    return _pattern.insertTemplateValues(
      {
        'date': date,
      },
      locale: locale,
    );
  }

  factory ExampleTemplatedDate.fromJson(Map<String, Object?> map) =>
      ExampleTemplatedDate(
        simple: map['simple']! as String,
        pattern: map['pattern']! as String,
      );

  ExampleTemplatedDate copyWith({
    String? simple,
    String? pattern,
  }) =>
      ExampleTemplatedDate(
        simple: simple ?? _simple,
        pattern: pattern ?? _pattern,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleTemplatedDate &&
          _simple == other._simple &&
          _pattern == other._pattern);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ _simple.hashCode ^ _pattern.hashCode;
}

class ExamplePlurals {
  const ExamplePlurals({
    required String manZero,
    required String manOne,
    required String manMultiple,
  })  : _manZero = manZero,
        _manOne = manOne,
        _manMultiple = manMultiple;

  final String _manZero;
  final String _manOne;
  final String _manMultiple;

  String man({
    required Plural plural,
  }) {
    if (plural == Plural.zero) {
      return _manZero;
    }
    if (plural == Plural.one) {
      return _manOne;
    }
    if (plural == Plural.multiple) {
      return _manMultiple;
    }
    throw Exception();
  }

  factory ExamplePlurals.fromJson(Map<String, Object?> map) => ExamplePlurals(
        manZero: map['manZero']! as String,
        manOne: map['manOne']! as String,
        manMultiple: map['manMultiple']! as String,
      );

  ExamplePlurals copyWith({
    String? manZero,
    String? manOne,
    String? manMultiple,
  }) =>
      ExamplePlurals(
        manZero: manZero ?? _manZero,
        manOne: manOne ?? _manOne,
        manMultiple: manMultiple ?? _manMultiple,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamplePlurals &&
          _manZero == other._manZero &&
          _manOne == other._manOne &&
          _manMultiple == other._manMultiple);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      _manZero.hashCode ^
      _manOne.hashCode ^
      _manMultiple.hashCode;
}
