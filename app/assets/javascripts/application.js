// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery.jpostal
//= require_tree .

//画面サイズによるCSSの処理
const $win = $(window);

$win.on('load resize', function() {
  const windowWidth = window.innerWidth;

  if (windowWidth <= 600) {
    $(".top-main").children("div").toggleClass("flex");
  }
});


//緯度経度から住所を取得
$(function() {

  // top.html.erb(:1 JSONタグ)が読み込まれたら現在地を取得開始
  $("#restaurants_json").ready(function() {
    $("#loading").append("(読み込み中)");
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {

        const CurrentLat = position.coords.latitude;
        const CurrentLng = position.coords.longitude;
        $("#latitude").text(label_latitude + CurrentLat)
        $("#longitude").text(label_longitude + CurrentLng)

        //現在地を地図上に表示
        $(function() {
          map = new google.maps.Map(document.getElementById("map"), {
            center: {lat: CurrentLat, lng: CurrentLng},
            zoom: 13
          });
          marker = new google.maps.Marker({
            position: new google.maps.LatLng(CurrentLat, CurrentLng),
            map: map
          });
          infoWindow = new google.maps.InfoWindow({
            content: "現在地付近"
          });
          marker.addListener("click", function(){
            infoWindow.open(map, marker);
          });

          // レストラン情報を地図上に表示
          const restaurants = gon.restaurants;
          $(function(){
            for (let i = 0; i < restaurants.length; i++) {
              let address = restaurants[i].prefecture + restaurants[i].city + restaurants[i].street;
              const geocoder = new google.maps.Geocoder();
              geocoder.geocode(
                {"address": address},
                function(result, status) {
                  if (status == google.maps.GeocoderStatus.OK) {
                    var lat = result[0].geometry.location.lat();
                    var lng = result[0].geometry.location.lng();
                    marker[i] = new google.maps.Marker({
                      position: new google.maps.LatLng(lat, lng),
                      map: map
                    });
                    i = i + 1;
                    var link = "https://matchi-gourmet/public/restaurants/"+i;
                    i = i - 1;
                    infoWindow[i] = new google.maps.InfoWindow(
                      {
                        content: restaurants[i].name + '<br><a href='+link+'>詳細</a>',
                      },
                    );
                    marker[i].addListener("click", function(){
                      infoWindow[i].open(map, marker[i]);
                    });
                  } else {
                    $(".location-result" + ".error").removeClass("hedden");
                  }
                }
              );
            }
          });
        });
        $("#loading").remove();
      });
    } else {
      $(".location-result" + ".false").removeClass("hidden");
      // レストラン情報を地図上に表示
      const restaurants = gon.restaurants;
      $(function(){
        for (let i = 0; i < restaurants.length; i++) {
          let address = restaurants[i].prefecture + restaurants[i].city + restaurants[i].street;
          const geocoder = new google.maps.Geocoder();
          geocoder.geocode(
            {"address": address},
            function(result, status) {
              if (status == google.maps.GeocoderStatus.OK) {
                var lat = result[0].geometry.location.lat();
                var lng = result[0].geometry.location.lng();
                marker[i] = new google.maps.Marker({
                  position: new google.maps.LatLng(lat, lng),
                  map: map
                });
                i = i + 1;
                var link = "https://matchi-gourmet/public/restaurants/"+i;
                i = i - 1;
                infoWindow[i] = new google.maps.InfoWindow(
                  {
                    content: restaurants[i].name + '<br><a href='+link+'>詳細</a>',
                  },
                );
                marker[i].addListener("click", function(){
                  infoWindow[i].open(map, marker[i]);
                });
              } else {
                $(".location-result" + ".error").removeClass("hedden");
              }
            }
          );
        }
      });
      $("#loading").remove();
    }
  });

  // geolocationが使えるかどうかの処理（ウインドウ）
  $("#get-position").on("click", function() {
    if (navigator.geolocation) {
      $(".location-result" + ".true").removeClass("hidden");
    }
  });

});
