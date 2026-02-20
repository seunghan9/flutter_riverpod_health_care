/// 폼 유효성 검증을 위한 공통 Validator 클래스
///
/// 사용법:
/// ```dart
/// CustomTextField(
///   validator: FormValidators.email,
///   // 또는 조합하여 사용
///   validator: FormValidators.compose([
///     FormValidators.required('이름을 입력해주세요'),
///     FormValidators.minLength(2, '이름은 2자 이상 입력해주세요'),
///   ]),
/// )
/// ```
class FormValidators {
  FormValidators._(); // 인스턴스 생성 방지

  // ========================================
  // 기본 Validators
  // ========================================

  /// 필수 입력 검증
  static String? Function(String?) required([String? message]) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return message ?? '필수 입력 항목입니다';
      }
      return null;
    };
  }

  /// 최소 길이 검증
  static String? Function(String?) minLength(int length, [String? message]) {
    return (String? value) {
      if (value == null || value.length < length) {
        return message ?? '최소 $length자 이상 입력해주세요';
      }
      return null;
    };
  }

  /// 최대 길이 검증
  static String? Function(String?) maxLength(int length, [String? message]) {
    return (String? value) {
      if (value != null && value.length > length) {
        return message ?? '최대 $length자까지 입력 가능합니다';
      }
      return null;
    };
  }

  /// 정확한 길이 검증
  static String? Function(String?) exactLength(int length, [String? message]) {
    return (String? value) {
      if (value == null || value.length != length) {
        return message ?? '정확히 $length자를 입력해주세요';
      }
      return null;
    };
  }

  // ========================================
  // 이메일 Validators
  // ========================================

  /// 기본 이메일 형식 검증
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '이메일을 입력해주세요';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return '올바른 이메일 형식이 아닙니다';
    }

    return null;
  }

  /// 커스텀 메시지가 있는 이메일 검증
  static String? Function(String?) emailWithMessage({
    String? requiredMessage,
    String? formatMessage,
  }) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return requiredMessage ?? '이메일을 입력해주세요';
      }

      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
        return formatMessage ?? '올바른 이메일 형식이 아닙니다';
      }

      return null;
    };
  }

  // ========================================
  // 비밀번호 Validators
  // ========================================

  /// 기본 비밀번호 검증 (6자 이상)
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    }

    if (value.length < 6) {
      return '6자 이상 입력해주세요';
    }

    return null;
  }

  /// 강력한 비밀번호 검증 (영문+숫자 포함, 6자 이상)
  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    }

    if (value.length < 6) {
      return '6자 이상 입력해주세요';
    }

    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
      return '영문과 숫자를 포함해주세요';
    }

    return null;
  }

  /// 매우 강력한 비밀번호 검증 (영문+숫자+특수문자, 8자 이상)
  static String? veryStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    }

    if (value.length < 8) {
      return '8자 이상 입력해주세요';
    }

    if (!RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])',
    ).hasMatch(value)) {
      return '영문, 숫자, 특수문자를 모두 포함해주세요';
    }

    return null;
  }

  /// 비밀번호 확인 검증
  static String? Function(String?) confirmPassword(String originalPassword) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return '비밀번호 확인을 입력해주세요';
      }

      if (value != originalPassword) {
        return '비밀번호가 일치하지 않습니다';
      }

      return null;
    };
  }

  // ========================================
  // 이름 Validators
  // ========================================

  /// 한글 이름 검증
  static String? koreanName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '이름을 입력해주세요';
    }

    if (value.trim().length < 2) {
      return '이름은 2자 이상 입력해주세요';
    }

    if (!RegExp(r'^[가-힣]+$').hasMatch(value.trim())) {
      return '한글 이름만 입력 가능합니다';
    }

    return null;
  }

  /// 영문 이름 검증
  static String? englishName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '이름을 입력해주세요';
    }

    if (value.trim().length < 2) {
      return '이름은 2자 이상 입력해주세요';
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return '영문 이름만 입력 가능합니다';
    }

    return null;
  }

  /// 일반 이름 검증 (한글, 영문 모두 허용)
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '이름을 입력해주세요';
    }

    if (value.trim().length < 2) {
      return '이름은 2자 이상 입력해주세요';
    }

    return null;
  }

  // ========================================
  // 전화번호 Validators
  // ========================================

  /// 한국 휴대폰 번호 검증
  static String? phoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '전화번호를 입력해주세요';
    }

    // 하이픈 제거
    final cleanValue = value.replaceAll('-', '').replaceAll(' ', '');

    if (!RegExp(r'^010[0-9]{8}$').hasMatch(cleanValue)) {
      return '올바른 휴대폰 번호를 입력해주세요 (010-XXXX-XXXX)';
    }

    return null;
  }

  // ========================================
  // 숫자 Validators
  // ========================================

  /// 정수 검증
  static String? integer(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '숫자를 입력해주세요';
    }

    if (int.tryParse(value.trim()) == null) {
      return '정수만 입력 가능합니다';
    }

    return null;
  }

  /// 범위 내 숫자 검증
  static String? Function(String?) numberInRange(int min, int max) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return '숫자를 입력해주세요';
      }

      final number = int.tryParse(value.trim());
      if (number == null) {
        return '정수만 입력 가능합니다';
      }

      if (number < min || number > max) {
        return '$min ~ $max 사이의 숫자를 입력해주세요';
      }

      return null;
    };
  }

  // ========================================
  // 조합 Validators
  // ========================================

  /// 여러 validator를 조합하여 모든 조건을 검사
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }

  /// 여러 validator 중 하나라도 통과하면 성공
  static String? Function(String?) any(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        if (validator(value) == null) return null;
      }
      return '입력 형식이 올바르지 않습니다';
    };
  }

  // ========================================
  // 특수 용도 Validators
  // ========================================

  /// URL 검증
  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL을 입력해주세요';
    }

    if (!RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    ).hasMatch(value.trim())) {
      return '올바른 URL 형식이 아닙니다';
    }

    return null;
  }

  /// 생년월일 검증 (YYYY-MM-DD 또는 YYYY.MM.DD 또는 YYYY/MM/DD)
  static String? birthDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '생년월일을 입력해주세요';
    }

    if (!RegExp(r'^\d{4}[-.\/]\d{1,2}[-.\/]\d{1,2}$').hasMatch(value.trim())) {
      return '올바른 날짜 형식이 아닙니다 (YYYY-MM-DD)';
    }

    return null;
  }
}
