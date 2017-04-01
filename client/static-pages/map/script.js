var tree = {
  getTree: function () {
    return new Promise(function (resolve, reject) {
      axios.get('http://foncoreapi.azurewebsites.net/tree')
        .then(function (response) {
          console.log(response.data);
          resolve(response.data);
        })
        .catch(function (error) {
          reject(error);
        })
    });
  }
};

var modal = new tingle.modal({
  cssClass: ['modal']
});
function openModal(image, name) {
  var content = "<h1>Drvo od "+ name +"</h1>";
  content += "<img src='"+ image +"'/>";
  modal.setContent(content);
  modal.open();
}

function generateMarkers(markers, map) {
  var position;
  var markersArr = [];
  markers.forEach(function (marker) {
    position = {lat: marker.lat, lng: marker.lng};
    markersArr.push(new google.maps.Marker({
      position: position,
      map: map,
    }));
    markersArr[markersArr.length-1].addListener('click', function() {
      openModal(marker.image, marker.kid.name);
    })
  });
}

function initMap() {
  var position = {lat: 44.772863, lng: 20.475252};
  var mapElem = document.getElementById('map');
  var map = new google.maps.Map(mapElem, {
    zoom: 16,
    center: position
  });

  tree.getTree()
    .then(function(markers) {
      generateMarkers(markers, map);
    })
    .catch(function(error) {
      console.log(error);
    });

  mapElem.style.width = window.innerWidth + 'px';
  mapElem.style.height = window.innerHeight + 'px';
}
