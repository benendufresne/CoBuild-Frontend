class StaticContentModel {
  String? aboutUs;
  String? privacyPolicy;
  String? termsAndConditions;
  String? url;
  String? heading;

  StaticContentModel(
      {this.aboutUs,
      this.privacyPolicy,
      this.termsAndConditions,
      this.url,
      this.heading});

  StaticContentModel copyWith({
    String? aboutUs,
    String? privacyPolicy,
    String? termsAndConditions,
    String? support,
    String? ourVision,
    String? heading,
    String? url,
  }) {
    return StaticContentModel(
      aboutUs: aboutUs ?? this.aboutUs,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      url: url ?? this.url,
      heading: heading ?? this.heading,
    );
  }
}
