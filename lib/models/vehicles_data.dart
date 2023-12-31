import 'package:nft_market_place/models/person.dart';
import 'package:nft_market_place/models/vehicle.dart';

final List<CommercialLogisticsVehicle> sampleVehicles = [
  CommercialLogisticsVehicle(
    name: 'Mercedes-Benz Actros',
    type: 'Semi-Truck',
    description: 'A premium long-haul truck known for comfort and efficiency.',
    brand: 'Mercedes-Benz',
    regPlateID: 'ABC123',
    onSale: false,
    carryingWeightMax: '40,000 kg',
    carryingWeightMin: '10,000 kg',
    minimumPrice: '\$80,000',
    engineNumber: 'MB12345',
    routesActive: true,
    provider: Person(firstName: 'Logistics Inc.', lastName: ' 5'),
    driver: Person(firstName: 'John Driver', lastName: ' 35'),
  ),
  CommercialLogisticsVehicle(
    name: 'Ford Transit',
    type: 'Cargo Van',
    description: 'A versatile van for local deliveries and small businesses.',
    brand: 'Ford',
    regPlateID: 'XYZ456',
    onSale: true,
    carryingWeightMax: '2,000 kg',
    carryingWeightMin: '500 kg',
    minimumPrice: '\$20,000',
    engineNumber: 'FT7890',
    routesActive: false,
    provider: Person(firstName: 'Express Delivery', lastName: ' 8'),
    driver: Person(firstName: 'Anna Smith', lastName: ' 28'),
  ),
  CommercialLogisticsVehicle(
    name: 'Volvo FH16',
    type: 'Semi-Truck',
    description: 'A powerful truck built for heavy loads and long distances.',
    brand: 'Volvo',
    regPlateID: 'LMN789',
    onSale: false,
    carryingWeightMax: '60,000 kg',
    carryingWeightMin: '20,000 kg',
    minimumPrice: '\$100,000',
    engineNumber: 'VOLVO9876',
    routesActive: true,
    provider: Person(firstName: 'Global Logistics', lastName: ' 12'),
    driver: Person(firstName: 'David Johnson', lastName: ' 40'),
  ),
  CommercialLogisticsVehicle(
    name: 'Isuzu NPR',
    type: 'Box Truck',
    description: 'A compact truck for urban deliveries and small businesses.',
    brand: 'Isuzu',
    regPlateID: 'PQR123',
    onSale: true,
    carryingWeightMax: '5,000 kg',
    carryingWeightMin: '1,000 kg',
    minimumPrice: '\$25,000',
    engineNumber: 'ISUZU4567',
    routesActive: false,
    provider: Person(firstName: 'City Cargo', lastName: ' 6'),
    driver: Person(firstName: 'Maria Martinez', lastName: ' 32'),
  ),
  CommercialLogisticsVehicle(
    name: 'Kenworth W990',
    type: 'Semi-Truck',
    description: 'A classic American truck known for its iconic design.',
    brand: 'Kenworth',
    regPlateID: 'JKL555',
    onSale: true,
    carryingWeightMax: '45,000 kg',
    carryingWeightMin: '15,000 kg',
    minimumPrice: '\$90,000',
    engineNumber: 'KW5555',
    routesActive: true,
    provider: Person(firstName: 'American Haulers', lastName: ' 15'),
    driver: Person(firstName: 'Michael Brown', lastName: ' 45'),
  ),
  CommercialLogisticsVehicle(
    name: 'Chevrolet Express',
    type: 'Cargo Van',
    description: 'A reliable van for various cargo transport needs.',
    brand: 'Chevrolet',
    regPlateID: 'CHEVY789',
    onSale: false,
    carryingWeightMax: '3,000 kg',
    carryingWeightMin: '800 kg',
    minimumPrice: '\$22,000',
    engineNumber: 'CHEVY987',
    routesActive: false,
    provider: Person(firstName: 'Express Cargo', lastName: ' 7'),
    driver: Person(firstName: 'Daniel Lee', lastName: ' 30'),
  ),
  CommercialLogisticsVehicle(
    name: 'Freightliner Cascadia',
    type: 'Semi-Truck',
    description:
        'A fuel-efficient truck designed for long-haul transportation.',
    brand: 'Freightliner',
    regPlateID: 'FREIGHT123',
    onSale: true,
    carryingWeightMax: '55,000 kg',
    carryingWeightMin: '18,000 kg',
    minimumPrice: '\$95,000',
    engineNumber: 'FL1234',
    routesActive: true,
    provider: Person(firstName: 'Long Haul Logistics', lastName: ' 10'),
    driver: Person(firstName: 'Emily White', lastName: ' 34'),
  ),
  CommercialLogisticsVehicle(
    name: 'Ram ProMaster',
    type: 'Cargo Van',
    description: 'A versatile van suitable for various cargo transport needs.',
    brand: 'Ram',
    regPlateID: 'RAM456',
    onSale: true,
    carryingWeightMax: '2,500 kg',
    carryingWeightMin: '600 kg',
    minimumPrice: '\$21,000',
    engineNumber: 'RAM7890',
    routesActive: false,
    provider: Person(firstName: 'Ram Logistics', lastName: ' 9'),
    driver: Person(firstName: 'Tom Wilson', lastName: ' 29'),
  ),
  CommercialLogisticsVehicle(
    name: 'Peterbilt 579',
    type: 'Semi-Truck',
    description:
        'A popular choice for long-distance hauls with modern features.',
    brand: 'Peterbilt',
    regPlateID: 'PETER579',
    onSale: true,
    carryingWeightMax: '50,000 kg',
    carryingWeightMin: '17,000 kg',
    minimumPrice: '\$92,000',
    engineNumber: 'P579XYZ',
    routesActive: true,
    provider: Person(firstName: 'Premium Haulage', lastName: ' 11'),
    driver: Person(firstName: 'Olivia Davis', lastName: ' 33'),
  ),
  CommercialLogisticsVehicle(
    name: 'Nissan NV200',
    type: 'Cargo Van',
    description:
        'A compact and efficient van for city deliveries and small businesses.',
    brand: 'Nissan',
    regPlateID: 'NISSAN200',
    onSale: true,
    carryingWeightMax: '2,200 kg',
    carryingWeightMin: '500 kg',
    minimumPrice: '\$18,000',
    engineNumber: 'NV200ABC',
    routesActive: false,
    provider: Person(firstName: 'City Express', lastName: ' 5'),
    driver: Person(firstName: 'Sophia Clark', lastName: ' 31'),
  ),
];
