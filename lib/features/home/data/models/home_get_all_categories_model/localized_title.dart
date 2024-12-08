class LocalizedTitle {
  String? en;
  String? ar;

  LocalizedTitle({this.en, this.ar});

  factory LocalizedTitle.fromJson(Map<String, dynamic> json) {
    return LocalizedTitle(
      en: json['en'] as String?,
      ar: json['ar'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'en': en,
        'ar': ar,
      };
}
