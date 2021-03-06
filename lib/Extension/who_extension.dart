import '../Core/login_modal_view.dart';

extension WhoExtension on Who {
  String get name {
    switch (this) {
      case Who.HASTA:
        return 'HASTA';
      case Who.HEMSIRE:
        return 'HEMŞİRE';
    }
  }

  String get firebaseCollectionName {
    switch (this) {
      case Who.HASTA:
        return 'patients';
      case Who.HEMSIRE:
        return 'nurses';
    }
  }
}
