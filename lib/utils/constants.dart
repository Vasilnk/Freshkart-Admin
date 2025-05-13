class Constants {
  static List<String> addItems = [
    'Products',
    'Cover Images',
    'Add Notifications',
    'Offer Products',
  ];
  static List<String> statusList = [
    'All',
    'Pending',
    'Confirmed',
    'Packed',
    'Out for Delivery',
    'Delivered',
    'Cancelled',
  ];
  static List<String> status = [
    'Confirm',
    'Packed',
    'Out for Delivery',
    'Delivered',
  ];
  static const Map<String, List<String>> validNextStatuses = {
    'Pending': ['Confirm', 'Cancelled'],
    'Confirmed': ['Packed', 'Cancelled'],
    'Packed': ['Out for Delivery'],
    'Out for Delivery': ['Delivered'],
    'Delivered': [],
    'Cancelled': [],
  };
}
