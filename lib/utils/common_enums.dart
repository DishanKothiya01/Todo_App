library;


/// ***********************************************************************************
/// *                                  LOCAL ENUMS                                    *
/// ***********************************************************************************

///* APPLICATION ENVIRONMENT TYPES - USE IN API STATES
enum EnvironmentType {
  local(id: 0, label: 'Local', slug: 'local'),
  development(id: 1, label: 'Development', slug: 'development'),
  staging(id: 2, label: 'Staging', slug: 'staging'),
  production(id: 3, label: 'Production', slug: 'production');

  final int id;
  final String label;
  final String slug;

  const EnvironmentType({
    required this.id,
    required this.label,
    required this.slug,
  });

  static EnvironmentType fromSlug(String slug) {
    return EnvironmentType.values.firstWhere((e) => e.slug == slug);
  }
}

///* APPLICATION NOTIFICATION STATES
enum NotificationState { open, background, kill }

///* RADIO BUTTON TYPES
enum RadioButtonType { outline, filled, done }

///* IMAGE OR ICON ALIGNS IN APP BUTTON
enum CustomAlign { start, startTitle, endTitle, end }

// ///* CUSTOM SNACK-BAR TYPE
// enum SnackbarType { complete, wrong, warning }

///* APP BUTTON VARIANTS
enum ButtonType {
  elevated(id: 0, label: "Elevated", slug: "elevated"),
  gradient(id: 1, label: "Gradient", slug: "gradient"),
  outline(id: 2, label: "Outline", slug: "outline");

  final int id;
  final String label;
  final String slug;

  const ButtonType({
    required this.id,
    required this.label,
    required this.slug,
  });

  static ButtonType fromSlug(String slug) {
    return ButtonType.values.firstWhere((e) => e.slug == slug);
  }
}

///* Signup Screen Enum
enum SignupScreenTypes {
  signupScreen(id: 0, slug: "signupScreen", label: "SignUp Screen"),
  otpVerification(id: 1, slug: "otpVerification", label: "OTP Verification"),
  addAddress(id: 2, slug: "addAddress", label: "Add Address");

  final int id;
  final String slug;
  final String label;

  const SignupScreenTypes({
    required this.id,
    required this.slug,
    required this.label,
  });
}

///* Signup Screen Enum
enum LoginScreenTypes {
  loginScreen(id: 0, slug: "loginScreen", label: "Login Screen"),
  otpVerification(id: 1, slug: "otpVerification", label: "OTP Verification");

  final int id;
  final String slug;
  final String label;

  const LoginScreenTypes({
    required this.id,
    required this.slug,
    required this.label,
  });
}

///* Signup Screen Enum
enum FilterEnumTypes {
  alpha(id: 0, slug: "alpha", label: "Alphabetical (default)", shortName: "Alpha"),
  lTOH(id: 1, slug: "lTOH", label: "Price (Low to High)", shortName: "Low-High"),
  hToL(id: 2, slug: "hToL", label: "Price (High to Low)", shortName: "High-Low");

  final int id;
  final String slug;
  final String label;
  final String shortName;

  const FilterEnumTypes({
    required this.id,
    required this.slug,
    required this.label,
    required this.shortName,
  });
}

// ///* Address Type Enum
// enum AddressType {
//   home(id: 1, slug: "home", label: "Home", image: AppAssets.homeIcon),
//   work(id: 2, slug: "work", label: "Work", image: AppAssets.officeIcon),
//   friendsAndFamily(id: 3, slug: "friends_and_family", label: "Friends & Family", image: AppAssets.peopleIcon),
//   others(id: 4, slug: "others", label: "Others", image: AppAssets.moreIcon);
//
//   final int id;
//   final String slug;
//   final String label;
//   final String image;
//
//   const AddressType({
//     required this.id,
//     required this.slug,
//     required this.label,
//     required this.image,
//   });
//
//   /// Helper to get AddressType from slug string
//   static AddressType getAddressTypeFromSlug(String? slug) {
//     return AddressType.values.firstWhere(
//       (type) => type.slug == slug,
//       orElse: () => AddressType.others,
//     );
//   }
// }

///* IMAGE OR ICON ALIGNS IN APP BUTTON
enum ImageAlign { start, startTitle, endTitle, end }

///* APP TEXT-FORM-FIELD VARIANTS
enum TextFieldType { normal, date, time, search }

///* CUSTOM SNACK-BAR TYPE
enum SnackBarType { complete, wrong, warning }

///* SCREEN STATES
enum ScreenState { add, update, readOnly }

///* API STATES
enum ApiState { initial, pagination, background, refresh }

///* Payment Processing

// enum PaymentProcessingState {
//   processing(
//     id: 0,
//     label: 'Payment Processing',
//     slug: 'payment_processing',
//     title: 'Processing Payment!',
//     image: AppAssets.paymentProcessingIcon,
//   ),
//   cancellation(
//     id: 1,
//     label: 'Payment Cancelled',
//     slug: 'payment_cancelled',
//     title: 'Processing Cancellation!',
//     image: AppAssets.cancelProcessingIcon,
//   );
//
//   final int id;
//   final String label;
//   final String slug;
//   final String title;
//   final String image;
//
//   const PaymentProcessingState({
//     required this.id,
//     required this.label,
//     required this.slug,
//     required this.title,
//     required this.image,
//   });
//
//   /// Helpers
//   bool get isProcessing => this == PaymentProcessingState.processing;
//
//   bool get isCancelled => this == PaymentProcessingState.cancellation;
//
//   /// Factory methods
//   static PaymentProcessingState fromId(int id) => PaymentProcessingState.values.firstWhere((e) => e.id == id);
//
//   static PaymentProcessingState fromSlug(String slug) => PaymentProcessingState.values.firstWhere((e) => e.slug == slug);
// }

///Order Tracking Status
enum TrackingOrderStatus {
  orderPlaced(
    id: 0,
    label: 'Order Placed',
    slug: 'order_placed',
    subtitle: 'Vayu One is gearing up to get your grocery.',
    time: '9:35',
  ),
  packingYourOrder(
    id: 1,
    label: 'Packing your Order',
    slug: 'packing',
    subtitle: 'Your groceries are being packed.',
    time: '9:40',
  ),
  outForDelivery(
    id: 2,
    label: 'Out for Delivery',
    slug: 'out_for_delivery',
    subtitle: 'Your order will be on the way soon.',
    time: '9:45',
  ),
  arrivingSoon(
    id: 3,
    label: 'Arriving Soon',
    slug: 'arriving_soon',
    subtitle: 'Enter code and collect your order. It’s almost there.',
    time: '9:55',
  );

  final int id;
  final String label;
  final String slug;
  final String subtitle;
  final String time;

  const TrackingOrderStatus({
    required this.id,
    required this.label,
    required this.slug,
    required this.subtitle,
    required this.time,
  });

  static TrackingOrderStatus fromSlug(String slug) {
    return TrackingOrderStatus.values.firstWhere((e) => e.slug == slug);
  }

  static TrackingOrderStatus fromId(int id) {
    return TrackingOrderStatus.values.firstWhere((e) => e.id == id);
  }
}
