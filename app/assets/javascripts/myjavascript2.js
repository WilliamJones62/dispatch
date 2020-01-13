function getData(data) {
  var p1 = data.replace('[', "");
  var p2 = p1.replace(']', "");
  p1 = p2.replace(/"/g, "");
  p2 = p1.replace(/,/g, "");
  var data_array = p2.split(" ");
  data_array.shift();
  data_array.pop();
  return data_array;
}

function setTruckData() {
  var x = document.getElementById("route_truck");
  var truck = x.value;
  var trucks = document.getElementById("trucks").innerHTML;
  var trucks_array = getData(trucks);
  var index = trucks_array.indexOf(truck.replace(/ /g, '~'));
  var tablets = document.getElementById("tablets").innerHTML;
  var tablets_array = getData(tablets);
  var tablet = tablets_array[index].replace(/~/g, ' ');
  var wexcards = document.getElementById("wexcards").innerHTML;
  var wexcards_array = getData(wexcards);
  var wexcard = wexcards_array[index].replace(/~/g, ' ');
  var ez_passes = document.getElementById("ez_passes").innerHTML;
  var ez_passes_array = getData(ez_passes);
  var ez_pass = ez_passes_array[index].replace(/~/g, ' ');
  var temp_statuses = document.getElementById("temp_statuses").innerHTML;
  var temp_statuses_array = getData(temp_statuses);
  var temp_verifieds = document.getElementById("temp_verifieds").innerHTML;
  var temp_verifieds_array = getData(temp_verifieds);
  var element = document.getElementById("Temperature");
  element.classList.remove("blinking");
  var temp_text = 'No temperature logger required';
  if (temp_statuses_array[index].replace(/~/g, ' ') != "ACTIVE" || temp_verifieds_array[index] == false) {
    temp_text = 'Issue a temperature logger';
    element.classList.add("blinking");
  }
  document.getElementById("Tablet").innerHTML = tablet;
  document.getElementById("Wexcard").innerHTML = wexcard;
  document.getElementById("EZPass").innerHTML = ez_pass;
  element.innerHTML = temp_text;
}
