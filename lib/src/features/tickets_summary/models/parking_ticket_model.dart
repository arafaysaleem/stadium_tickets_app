import '../../parking/parking.dart';

class ParkingTicketModel {
  final SpaceModel spaceModel;
  final int floorNo;

  const ParkingTicketModel({
    required this.spaceModel,
    required this.floorNo,
  });
}
