class CityData {
  final String state;
  final String confirmed;
  final List<DistrictData> districts;

  CityData(this.state, this.confirmed, this.districts);
}

class DistrictData {
  final String district;
  final String confirmed;
  final String active;
  final String recovered;
  final String deceased;

  DistrictData(
      this.district, this.confirmed, this.active, this.recovered, this.deceased);
}