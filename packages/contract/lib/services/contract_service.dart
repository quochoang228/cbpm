part of '../../contract.dart';

class IOCContractService {
  final IOCContactRepository contractRepository;

  IOCContractService(this.contractRepository);

  static String iocContactRequestType = '/ioc-contact-request-type';
  static String iocContactRequest = '/ioc-contact-request';
  static String iocContactRequestDetail = '/ioc-contact-request-detail';

  /// b2c
  static String iocContactRequestB2C = '/ioc-contact-request-b2c';
  static String iocContactRequestB2CDetail = '/ioc-contact-request-b2c-detail';

  static String iocContactRequestHouseModel =
      '/ioc-contact-request-house-model';
}
