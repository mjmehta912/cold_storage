import 'package:cold_storage/app/screens/auth/login/model/login_res_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

const String appName = 'Cold Storage';

const String kSplashScreenText = 'in your hand';
const String kDownload = 'Download';
const String kBulkDownload = 'Bulk Download';
const String kSettings = 'Settings';
const String kNotifications = 'Notifications';

const String kEnterMobileNo = 'Enter mobile number';
const String kMobileNo = 'Mobile No';
const String kMobileModel = 'Mobile Model';
const String kEnterUserName = 'Enter user name';
const String kUserName = 'User name';
const String kEnterPassword = 'Enter password';
const String kPassword = 'Password';
const String kForgotPassword = 'Forgot Password';
const String kLogin = 'Login';
const String kSelectYourCompany = 'Select your company';
const String kUsertype = 'Usertype';
const String kPartyCompanies = 'Party Companies';
const String kName = 'Name';
const String kHasChangedDevice = 'has changed device';
const String kRequestedOn = 'Requested on';
const String kActionBy = 'Action by';
const String kDevice = 'Device';
const String kTimestamp = 'Timestamp';

const String kRegister = 'Register';
const String kSearch = 'Search';
const String kSave = 'Save';
const String kYes = 'Yes';
const String kNo = 'No';
const String kLogout = 'Logout';
const String kReason = 'Reason';
const String kNotificationUpdater = 'Name of the accepted/rejecter';
const String kSubmit = 'Submit';
const String kOkay = 'Okay';
const String kMadeInIndia = 'Made in India';
const String kCopyRightText = 'Copyright © 2024 Jinee Infotech';

/// user type
const String kAdmin = 'Admin';
const String kStaffMember = 'Staff Member';
const String kUser = 'User';

const String kStatistics = 'Statistics';
const String kOutward = 'Outward';
const String kInwardStockLedger = 'Inward Stock \nLedger';
const String kStockSummary = 'Stock \nSummary';
const String kStockLedger = 'Stock \nLedger';
const String kStockLedgerReport = 'Stock Ledger Report';
const String kAccountLedger = 'Account \nLedger';
const String kAccountLedgerReport = 'Account Ledger Report';
const String kOutwardRequest = 'Outward \nRequest';
const String kViewOutwardRequest = 'View \nRequests';
const String kRegisterNewUser = 'Register New User';

/// drawer strings
const String kAdminAction = 'Admin action';
const String kGeneralAction = 'General action';
const String kAuthorizeRequest = 'Authorize request';
const String kUserRegistration = 'User Registration';
const String kChangeCompany = 'Change Company';

/// inward stock ledger strings
const String kFrom = 'From';
const String kTo = 'To';
const String kFromDate = 'From Date';
const String kToDate = 'To Date';
const String kCustomers = 'Customers';
const String kItems = 'Items';
const String kViewBy = 'View By';
const String kClosingBal = 'Closing Balance';
const String kShowInward = 'Show Inward';
const String kSearchByInwardNo = 'Search by Inward No.';
const String kInwardNo = 'Inward No';
const String kDate = 'Date';
const String kDeliveryDate = 'Delivery Date';
const String kOpeningQty = 'Opening Qty';
const String kInward = 'Inward';
const String kBalance = 'Balance';
const String kIWQty = 'I/W Qty';
const String kOW = 'O/W';
const String kQty = 'Qty';

/// stock ledger report
const String kOutwardNo = 'Outward No';

/// account ledger report
const String kSalesMan = 'Sales Man';
const String kDoc = 'Doc';
const String kNarration = 'Narration';
const String kBook = 'Book';
const String kDebit = 'Debit';
const String kCredit = 'Credit';
const String kCLOSINGBALANCE = 'CLOSING BALANCE';
const String kOpening = 'Opening';
const String kAmount = 'Amount';

/// outwards details
const String kOutwardDetails = 'Outward Details';
const String kRequestNo = 'Request No';
const String kTime = 'Time';
const String kItem = 'Item';
const String kCustomer = 'Customer';
const String kLotNo = 'Lot No';
const String kEntryDate = 'Entry Date';
const String kVehicleType = 'Vehicle Type';
const String kReject = 'Reject';
const String kAccept = 'Accept';
const String kAll = 'All';
const String kPending = 'Pending';
const String kAccepted = 'Accepted';
const String kRejected = 'Rejected';
const String kRejectedReqText = 'You are rejecting outward request of ';
const String kRejectedReqText2 = 'with Lot No';
const String kRemarksHere = 'Remarks here';
const String kStatus = 'Status';
const String kYourReqWillBeSendToAdmin = 'Your request will be send to admin';
const String kNewVersionDialogTitleText =
    'Older version detected.\n Please update latest version.';

/// view by
const String kIndividual = 'Individual';
const String kConsolidated = 'Consolidated';

/// show inward
const String kComplete = 'Complete';

/// vehicle type
const String kPartyVehicle = 'Party Vehicle';
const String kColdVehicle = 'Cold Vehicle';

/// closing bal
const String kIsZero = 'is 0';
const String kAboveZero = 'Above 0';

const String kAreYouSureYouWantToDelete = 'Are you sure you want to delete';
const String kAreYouSureYouWantToLogout = 'Are you sure you want to logout';

const String kEmptyDoc = 'No Documents Found';
const String kErrorUserName = 'Please enter an username';
const String kErrorPasswordName = 'Please enter a password';
const String kErrorOrganizationName = 'Please enter organization name';
const String kErrorEnterReason = 'Please enter a reason';
const String kErrorSubscriptionOver =
    'Subscription is over. Please renew the plan.';

/// VALIDATION MESSAGE STRING
const kEmptyEmail = "Please enter an Email ID";
const kValidEmail = "Please enter a valid Email ID";
const kEmptyPassword = "Please enter a password";
const kValidPassword = "Please enter a valid password";
const kEmptyPhone = "Please enter a mobile number";
const kValidPhone = "Please enter a valid mobile number";
const kEmptyOtp = "Please enter an OTP";
const kValidOtp = "Please enter a valid OTP";
const kEmptyName = "Please enter your name";
const String kPleaseSelectCompany = 'Please select company';
const String kPleaseSelectCustomer = 'Please select customer';
const String kEnterQtyLessThanBalanceQty =
    'Entered quantity should be less than balance quantity';

const String kAreYouSure = 'Are you sure?';
const String kYouWantToLogOut = 'You want to logout?';

const String kRequestForLogin = 'Request for login';
const String kRequestForLoginSubTxt =
    'Are you sure you want to send request to admin?';

const String kNoDataFound = 'No data found';

class AppConst {
  static RxBool isApiCalling = false.obs;
  static Rx<LoginData> companyData = LoginData().obs;
  static String userName = '';
  static AndroidDeviceInfo? androidDeviceInfo;
  static PackageInfo? packageInfo;
}
