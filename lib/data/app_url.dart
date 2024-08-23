class AppUrl {
  static var baseUrl = "http://swabi.ap-south-1.elasticbeanstalk.com";
  static var baseUrlForImage = "http://swabi.ap-south-1.elasticbeanstalk.com";

  ///registration URL
  static var login = "$baseUrl/login";
  static var rentalDriverBookingList =
      "$baseUrl/rental/get_rental_booking_by_driverId";
  static var rentalBooking = "$baseUrl/rental/booking";
  static var rentalBookingCancel = "$baseUrl/rental/cancel_rental_booking";
  static var rentalBookingList = "$baseUrl/rental/get_rental_booking_by_userId";
  static var rentalViewDetails = "$baseUrl/rental/get_rental_booking_by_id";
  static var driverProfile = "$baseUrl/rental/get_rental_booking_by_driverId";
  static var driverProfileUpdate = "$baseUrl/driver/update_driver_details";
  static var driverBookingList =
      "$baseUrl/rental/get_rental_booking_by_driverId";
  static var driverBookingDetails = "$baseUrl/rental/get_rental_booking_by_id";
  static var driverBookingListUrl =
      "/package_booking/get_package_booking_by_driver_id";
  static var driverBookingDetailListUrl =
      "/package_booking/get_assigned_package_booking_detail";
  static var driverActivityStartUrl = "/package_booking/start_activity";
  static var driverActivityCompleteUrl = "/package_booking/complete_activity";
  static var driverPackageHistoryUrl =
      "/package_booking/get_package_booking_history_by_driver_id";
  static var driverProfileUpdateEndUrl = "/driver/update_driver_details";
}
