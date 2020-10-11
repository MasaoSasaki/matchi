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

// 地図情報取得
addEventListener('DOMContentLoaded', function() {
  if (document.getElementById("restaurants_json") != null) {
    // homes/top.html.erb(:1 JSONタグ)が読み込まれたら現在地を取得開始
    $("#restaurants_json").ready(function() {
      $("#loading").append("(読み込み中)");
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
          const CurrentLat = position.coords.latitude;
          const CurrentLng = position.coords.longitude;

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
                      let lat = result[0].geometry.location.lat();
                      let lng = result[0].geometry.location.lng();
                      marker[i] = new google.maps.Marker({
                        position: new google.maps.LatLng(lat, lng),
                        map: map
                      });
                      i = i + 1;
                      let link = "https://matchi-gourmet.com/restaurants/"+i;
                      i = i - 1;
                      infoWindow[i] = new google.maps.InfoWindow(
                        {
                          content: restaurants[i].name + '<br><a href='+link+'>詳細</a>',
                        }
                      );
                      marker[i].addListener("click", function(){
                        infoWindow[i].open(map, marker[i]);
                      });
                    } else {
                      $(".location-result" + ".error").removeClass("hidden");
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
                  var link = "https://matchi-gourmet.com/restaurants/"+i;
                  i = i - 1;
                  infoWindow[i] = new google.maps.InfoWindow(
                    {
                      content: restaurants[i].name + '<br><a href='+link+'>詳細</a>',
                    }
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

    // geolocationが使える場合、クリックで地図を表示
    $("#get-position").on("click", function() {
      if (navigator.geolocation) {
        $(".location-result" + ".true").removeClass("hidden");
      }
    });
  }
});

// ページトップにスクロール
const scrollIcon = document.getElementById("move-head--icon");
addEventListener('scroll', function() {
  if (pageYOffset == 0 ) {
    scrollIcon.classList.add("hidden");
  } else {
    scrollIcon.classList.remove("hidden");
  }
})
scrollIcon.addEventListener('click', function() {
  scrollTo({
    top: 0,
    left: 0,
    behavior: 'smooth'
  });
});

// ハンバーガーメニュー
$(function() {
  $(".hamburger").on("click", function() {
    $(this).toggleClass("circle");
    $(".hamburger-menu").toggleClass("menu-hide");
    $(".hamburger-menu").on("click", function() {
      close();
    });
    $("body").on("click", "main", function() {
      close();
    });
    function close() {
      if ($(".hamburger-menu").hasClass("menu-hide")) {
        $(".hamburger-menu").toggleClass("menu-hide");
        $(".hamburger").toggleClass("circle");
      }
    }
  });
});

// メニュー写真、店舗写真のプレビュー表示
const fileForm = document.getElementsByClassName("attachment_image");
const previewArea = document.getElementsByClassName("image-preview");
// どのattachment_fieldかを判別
for (let i = 0; i < fileForm.length; i++) {
  fileForm[i].addEventListener('change', function() {
    const fileType = fileForm[i].files[0].type;
    // 画像ファイル以外はリターン
    if (fileType != "image/gif" && fileType != "image/png" && fileType != "image/jpeg") { return }
    imagePreview(fileForm[i], previewArea[i]);
  });
}
// 画像プレビュー表示
function imagePreview(fileForm, previewArea) {
  const fileReader = new FileReader();
  fileReader.readAsDataURL(fileForm.files[0]);
  fileReader.onloadend = function() {
    const dataUrl = fileReader.result;
    previewArea.insertAdjacentHTML('afterbegin', `<img src="${dataUrl}">`);
    const tagList = document.getElementById("tag-list");

    // アップロードされた画像がメニュー画像ならRailsに画像データを渡す
    if (fileForm.id == "menu_menu_image") { sendImageData(tagList, dataUrl) }
  }
}
// Railsに画像データを送信
function sendImageData(tagList, dataUrl) {
  tagList.insertAdjacentHTML("beforebegin", `<button name="button" type="button" id="vision-api-event">タグを取得</button>`)
  const getTagsBtn = document.getElementById("vision-api-event");
  var end = dataUrl.indexOf(",");
  getTagsBtn.addEventListener('click', function() {
    getTagsBtn.innerText = "取得中...";
    $.ajax({
      url: '/owner/menus/get_vision_tags',
      type: 'POST',
      data: {
        menu_image: dataUrl.slice(end + 1)
      },
    }) .done(function() {
      getTagsBtn.innerText = "取得完了";
      getTagsBtn.classList.add("inactive");
    }) .fail(function() {
      getTagsBtn.innerText = "取得できませんでした。";
    });
  });
}

// xを押すとタグの削除
$(function() {
  $("body").on('click', ".menu-tag > a", function() {
    $(this).parents("p").remove();
  });
});
