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
//= stub flash_window
//= require_tree .

// 地図情報取得
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
              if (address == 0) { continue }
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
                        content: `<a href='${ link }'>${ restaurants[i].name }</a>`
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
          if (address == 0) { continue }
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
                    content: `<a href='${ link }'>${ restaurants[i].name }</a>`
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

// ハンバーガーメニュー
const hamburgerButton = document.getElementsByClassName("hamburger")[0];
const hamburgerMenu = document.getElementsByClassName("hamburger-menu")[0];
hamburgerButton.addEventListener('click', ()=>{
  hamburgerButton.classList.toggle("circle");
  hamburgerMenu.classList.toggle("hidden");
});
addEventListener('click', (e)=>{
  if (e.path[0].classList.contains("hamburger") || e.path[0].classList.contains("bar")) { return }
  hamburgerButton.classList.remove("circle");
  hamburgerMenu.classList.add("hidden");
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
    const tagList = document.getElementsByClassName("image-preview");
    // アップロードされた画像がメニュー画像ならボタンを表示する
    if (fileForm.id != "menu_menu_image") { return }
    tagList[0].insertAdjacentHTML(
      "afterend",
      `<button name="ja" type="button" class="vision-api-event btn btn-outline-dark">タグを取得(日本語)</button>
      <button name="pure" type="button" class="vision-api-event btn btn-outline-dark">タグを取得(英語)</button>
      <button name="all" type="button" class="vision-api-event btn btn-outline-dark">タグを取得(日本語・英語)</button>`
      );
    const getTagsBtn = document.getElementsByClassName("vision-api-event");
    for (let i = 0; i < getTagsBtn.length; i++) {
      sendImageData(dataUrl, getTagsBtn[i]);
    }
  }
}
// Railsに画像データを送信
function sendImageData(dataUrl, getTagsBtn) {
  const end = dataUrl.indexOf(",");
  const lang = getTagsBtn.name;
  getTagsBtn.addEventListener('click', function() {
    switch (lang) {
      case "pure":
        document.getElementsByName("all")[0].classList.add("inactive");
        break;
      case "ja":
        document.getElementsByName("all")[0].classList.add("inactive");
        break;
      default:
        document.getElementsByName("pure")[0].classList.add("inactive");
        document.getElementsByName("ja")[0].classList.add("inactive");
    }
    getTagsBtn.innerText = "取得中...";
    getTagsBtn.classList.add("inactive");
    $.ajax({
      url: '/owner/menus/get_vision_tags',
      type: 'POST',
      data: {
        menu_image: dataUrl.slice(end + 1),
        lang_data: lang
      },
    }) .done(function() {
      getTagsBtn.innerText = "取得完了";
    }) .fail(function() {
      getTagsBtn.innerText = "取得できませんでした。";
      getTagsBtn.classList.remove("inactive");
    });
  });
}
// xを押すとタグの削除
$(function() {
  $("body").on('click', ".menu-tag > a", function() {
    $(this).parents("p").remove();
  });
});
