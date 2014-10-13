Table table;

void tableSetup() {

  table = new Table();

  table.addColumn("ID");
  table.addColumn("Time");
  table.addColumn("Waypoint");
  table.addColumn("Longitude");
  table.addColumn("Latitude");
  table.addColumn("Heading");
  table.addColumn("Altitude (GPS)");
  table.addColumn("Speed");
  table.addColumn("Pressure");
  table.addColumn("Temperature (BMP)");
  table.addColumn("Temperature (DHT)");
  table.addColumn("Humidity");
  table.addColumn("Heat Index");
  table.addColumn("Throttle");
  table.addColumn("Ailerons");
  table.addColumn("Ailerons 2");
  table.addColumn("Elevator");
  table.addColumn("Rudder");
  table.addColumn("Gear");
}

void tableUpdate() {

  TableRow newRow = table.addRow();
  newRow.setInt("ID", table.getRowCount() - 1);
  newRow.setInt("Time", millis()); // Can use setSting for strings
  newRow.setInt("Waypoint", 100);
  newRow.setFloat("Longitude", lattitudeGPS);
  newRow.setFloat("Latitude", longitudeGPS);
  newRow.setFloat("Heading", headingGPS);
  newRow.setFloat("Altitude (GPS)", altitudeGPS); 
  newRow.setFloat("Speed", speedMpsGPS); 
  newRow.setFloat("Pressure", pressureMB); 
  newRow.setFloat("Temperature (BMP)", temperatureBMP); 
  newRow.setFloat("Temperature (DHT)", temperatureDHT); 
  newRow.setFloat("Humidity", humidityDHT); 
  newRow.setFloat("Heat Index", heatIndexDHT);
  newRow.setFloat("Throttle", throttle);
  newRow.setFloat("Ailerons", ailerons);
  newRow.setFloat("Ailerons 2", ailerons2);
  newRow.setFloat("Elevator", elevator);
  newRow.setFloat("Rudder", rudder);
  newRow.setFloat("Gear", gear);
}

void tableCheck() {
  int updateRate = 1500;

  if (millis() - tableLastChecked >= updateRate) {
    tableLastChecked = millis();
    tableUpdate();
  }
}

void saveTable() {
  saveTable(table, "data/Flight_Data.csv");
}
