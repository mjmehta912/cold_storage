class ApiConstants {
  static String baseUrl = 'http://demo.jineecs.in/CS/api';

  static String authentication = '/authentication';
  static String general = '/general';
  static String report = '/report';
  static String outward = '/outward';
  static String notification = '/notification';

  static String login = '$authentication/login';
  static String registerUser = '$authentication/registerUser';
  static String getItems = '$general/getItems';
  static String getCustomer = '$authentication/getCustomer';


  static String getInwardStockLedgerDetails = '$report/InwardStockLedger';
  static String getStockSummaryDetails = '$report/StockSummary';
  static String getStockLedgerDetails = '$report/StockLedger';
  static String getAccountLedgerReportDetails = '$report/AccountLedger';

  static String getInwardNos = '$outward/getInwardNos';
  static String getLotNos = '$outward/getLotNos';
  static String getLotBalance = '$outward/getLotBalance';
  static String getAllRequests = '$outward/getAllRequests';
  static String placeRequest = '$outward/placeRequest';
  static String authoriseRequest = '$outward/authoriseRequest';

  static String getNotification = '$notification/getNotification';
  static String changeDeviceRequest = '$notification/changeDeviceRequest';
  static String changeDeviceResponse = '$notification/changeDeviceResponse';
}