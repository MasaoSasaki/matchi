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
                      let link = "https://matchi-gourmet.com/public/restaurants/"+i;
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
                  var link = "https://matchi-gourmet.com/public/restaurants/"+i;
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

// ヘッダーにスクロール
addEventListener('DOMContentLoaded', function() {
  const scrollIcon = document.getElementById("move-head--icon");
  addEventListener('scroll', function() {
    if (pageYOffset == 0 ) {
      scrollIcon.classList.add("hidden");
    } else {
      scrollIcon.classList.remove("hidden");
    }
  })
  scrollIcon.addEventListener('click', function() {
    scrollTo(0, 0);
  });
});

// ヘッダーにスクロール(jQuery版)
// $(function() {
//   $("#move-head--icon").on("click", function(){
//     $('body,html').animate({scrollTop:0}, 200, 'swing');
//   });
// });

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

// メニュータグの追加(CoffeeScript owner/menus.coffeeに移動)
// addEventListener('DOMContentLoaded', function() {
//   const tagForm = document.getElementById("tag_name");
//   if (tagForm != null) {

//     function addTags() {
//       let tagName = tagForm.value;
//       document.getElementById("tag-list").insertAdjacentHTML('beforeend', `<p class="inline-block add-menu-tag"><span class="menu-tag">${tagName} <a>x</a></span></p>`)
//       document.getElementsByClassName("add-menu-tag")[0].insertAdjacentHTML('beforeend', `<input type="hidden" value="${tagName}" name="tag[]"></input>`)
//       tagForm.value = ""
//     }
//     // エンターキーを押して追加
//     tagForm.addEventListener('keypress', function(key) {
//       if (key.which == 13) {
//         addTags();
//       }
//     });
//     // 追加ボタンを押して追加
//     document.getElementsByClassName("add-tag-btn")[0].addEventListener('click', function() {
//       addTags();
//     });
//   }
// });

// xを押すとタグの削除
$(function() {
  $("body").on('click', ".menu-tag > a", function() {
    $(this).parents("p").remove();
  });
});

// メニュータグの追加(jQuery版)
// $(function() {
  //   function addTags() {
    //     var tagName = $("#tag_name").val();
    //     $("#tag_name").val("");
    //     $("#tag-list").append(`<p class="inline-block add-menu-tag"><span class="menu-tag">${tagName} <a>x</a></span></p>`);
    //     $(".add-menu-tag").append(`<input type="hidden" value="${tagName}" name="tag[]"></input>`);
    //   }
//   // エンターキーを押して追加
//   $("#tag_name").keypress(function(key) {
//     if (key.which == 13) {
//       addTags();
//     }
//   });
//   // 追加ボタンを押して追加
//   $(".add-tag-btn").on("click", function() {
//     addTags();
//   });
// });

// メニュー写真、店舗写真のプレビュー表示（JSONをAPIをRailsに任せるための準備）
// addEventListener('DOMContentLoaded', function() {
//   const fileForm = document.getElementsByClassName("attachment_image");
//   const previewArea = document.getElementsByClassName("image-preview");

//   for (let i = 0; i < fileForm.length; i++) {
//     fileForm[i].addEventListener('change', function() {
//       imagePreview(fileForm[i], previewArea[i]);
//     });
//   }

//   function imagePreview(fileForm, previewArea) {
//     console.log(fileForm.id)
//     const file = fileForm.files[0];
//     // 画像ファイル以外はリターン
//     if (file.type != "image/gif" && file.type != "image/png" && file.type != "image/jpeg") {
//       return;
//     }
//     const fileReader = new FileReader();
//     fileReader.onloadend = function() {
//       previewArea.insertAdjacentHTML('afterbegin', `<img src="${fileReader.result}">`);
//     }
//     fileReader.readAsDataURL(file);
//   }
// });

// メニュー写真、店舗写真にプレビューを表示
addEventListener('DOMContentLoaded', function() {
  const menuImageForm = document.getElementById("menu_menu_image");
  const restaurantImageForm = document.getElementById("restaurant_restaurant_image");
  if (menuImageForm || restaurantImageForm != null) {
    const googlePlatformAPIKey = gon.google_platform_api_key;
    const googlePlatformAPITagUrl = 'https://vision.googleapis.com/v1/images:annotate?key=';
    const apiTagUrl = googlePlatformAPITagUrl + googlePlatformAPIKey;
    $("#menu_menu_image, #restaurant_restaurant_image").on("change", function() {
      var file = $(this).prop('files')[0];
      if(!file.type.match('image.*')){
        return;
      }
      var fileReader = new FileReader();
      fileReader.onloadend = function() {
        var dataUrl = fileReader.result;
        $(".image-preview").append(`<img src="${dataUrl}">`);
        makeRequest(dataUrl, getAPIInfo);
      }
      fileReader.readAsDataURL(file);
    });

    // base64エンコード
    function makeRequest(dataUrl, callback) {
      var end = dataUrl.indexOf(",");
      var request = "{'requests': [{'image': {'content': '" + dataUrl.slice(end + 1) + "'}, 'features': [{'type': 'LABEL_DETECTION'}]}]}"
      callback(request)
    }

    // APIリクエスト
    function getAPIInfo(request) {
      $.ajax({
        url: apiTagUrl,
        type: 'POST',
        async: true,
        cache: false,
        data: request,
        dataType: 'json',
        contentType: 'application/json',
      }).done(function(result) {
        showResult(result);
      }).fail(function(result) {
        console.log('取得に失敗しました。');
      });
    }

    // JSONResult
    function showResult(result) {
      var responses = result.responses[0]
      for (let i = 0; i < responses.labelAnnotations.length; i++) {
        $("#tag-list").append(`<p class="inline-block" id=api-tag${i}><span class="menu-tag api-menu-tag">${responses.labelAnnotations[i].description} <a>x</a></span></p>`);
        $("#api-tag"+i).append(`<input type="hidden" value="${responses.labelAnnotations[i].description}" name="tag[]"></input>`);
      }
    }
  }
});

// // 新規会員登録フォームのバリデーション（confirmページをPOSTに変更したため廃止）
// addEventListener('DOMContentLoaded', function() {
//   if (document.getElementsByClassName("public-users-new")[0] != null) {
//     const newUserNameFamilyForm = document.getElementById("new-user-name_family");
//     const newUserNameFirstForm = document.getElementById("new-user-name_first");
//     const newUserNameFamilyKanaForm = document.getElementById("new-user-name_family_kana");
//     const newUserNameFirstKanaForm = document.getElementById("new-user-name_first_kana");
//     const newUserPhoneNumberForm = document.getElementById("new-user-phone_number");
//     const newUserEmailForm = document.getElementById("new-user-email");
//     const newUserPasswordForm = document.getElementById("new-user-password");
//     const newUserPasswordConfirmationForm = document.getElementById("new-user-password_confirmation");

//     const newUserSubmit = document.getElementById("new-user-submit");

//     let formArray = [
//       newUserNameFamilyForm,
//       newUserNameFirstForm,
//       newUserNameFamilyKanaForm,
//       newUserNameFirstKanaForm,
//       newUserPhoneNumberForm,
//       newUserEmailForm,
//       newUserPasswordForm,
//       newUserPasswordConfirmationForm
//     ];

//     function nameForm(form, span) {
//       form.className = "success-form";
//       span.textContent = "OK";
//       span.className = "success-message";
//     }

//     function nameKanaForm(form, span) {
//       if (form.value.match(/^[ァ-ンヴー]*$/)) {
//         form.className = "success-form";
//         span.textContent = "OK";
//         span.className = "success-message";
//       } else {
//         form.className = "error-form";
//         span.textContent = "カナ文字をご入力ください。";
//         span.className = "error-message";
//       }
//     }

//     function passwordForm(form, span) {
//       if (form.value.match(/^[0-9a-zA-Z]*$/)) {
//         if (6 <= form.value.length) {
//           form.className = "success-form";
//           span.textContent = "OK";
//           span.className = "success-message";
//         } else {
//           form.className = "error-form";
//           span.textContent = "6桁以上をご入力ください。";
//           span.className = "error-message";
//         }
//       } else {
//         form.className = "error-form";
//         span.textContent = "半角英数字(6桁以上)のみご入力ください。";
//         span.className = "error-message";
//       }
//     }

//     function passwordConfirmationForm(form, span) {
//       // passwordForm(form, span);
//       if (form.value !== newUserPasswordForm.value) {
//         form.className = "error-form";
//         span.textContent = "パスワードが一致しません。";
//         span.className = "error-message";
//       } else {
//         form.className = "success-form";
//         span.textContent = "OK";
//         span.className = "success-message";
//       }
//     }

//     function validation(form, span) {
//       if (form.value == "") {
//         form.className = "error-form";
//         span.textContent = "入力必須項目です。";
//         span.className = "error-message";
//       } else {
//         switch (form) {
//           // 名前（漢字）フォーム
//           case newUserNameFamilyForm:
//             nameForm(form, span);
//             break
//           case newUserNameFirstForm:
//             nameForm(form, span);
//             break
//           // 名前（カナ）フォーム
//           case newUserNameFamilyKanaForm:
//             nameKanaForm(form, span);
//             break
//           case newUserNameFirstKanaForm:
//             nameKanaForm(form, span);
//             break

//           // 電話番号フォーム
//           case newUserPhoneNumberForm:
//             if (form.value.match(/^[0-9]*$/)) {
//               if (9 <= form.value.length && form.value.length <= 11) {
//                 form.className = "success-form";
//                 span.textContent = "OK";
//                 span.className = "success-message";
//               } else {
//                 form.className = "error-form";
//                 span.textContent = "9桁~11桁をご入力ください。";
//                 span.className = "error-message";
//               }
//             } else {
//               form.className = "error-form";
//               span.textContent = "半角数字(9桁~11桁)のみご入力ください。";
//               span.className = "error-message";
//             }
//             break

//           // メールアドレスフォーム
//           case newUserEmailForm:
//             if (form.value.match(/@/)) {
//               form.className = "success-form";
//               span.textContent = "OK";
//               span.className = "success-message";
//             } else {
//               form.className = "error-form";
//               span.textContent = "入力された値は無効です。";
//               span.className = "error-message";
//             }
//             break

//           // パスワードフォーム
//           case newUserPasswordForm:
//             passwordForm(form, span);
//             break
//           case newUserPasswordConfirmationForm:
//             passwordConfirmationForm(form, span);
//             break
//         }
//       }
//     }

//     for (let i = 0; i < formArray.length; i++) {
//       formArray[i].addEventListener('focusout', function() {
//         // フォームに値が入力されているかどうか？
//         validation(formArray[i], document.getElementById(`${formArray[i].id}--notice`));
//         if (document.getElementsByClassName("success-message").length === 8) {
//           newUserSubmit.classList.remove("inactive");
//         } else if (newUserSubmit.classList.contains("inactive") == false) {
//           newUserSubmit.classList.add("inactive");
//         }
//       });
//     }
//   }
// });

// // コンタクトフォームのバリデーション(confirmページをPOSTに変更したため廃止)
// addEventListener('DOMContentLoaded', function() {
//   if (document.getElementsByClassName("contacts-new")[0] != null) {
//     const newEmailForm = document.getElementById("contacts-new__email-form");
//     const newMessageForm = document.getElementById("contacts-new__message-form");


//     const newContactSubmit = document.getElementById("new-contacts-submit");

//     let formArray = [newEmailForm, newMessageForm]

//     function messageForm(form, span) {
//       form.className = "success-form";
//       span.textContent = "OK";
//       span.className = "success-message";
//     }

//     function validation(form, span) {
//       if (form.value == "") {
//         form.className = "error-form";
//         span.textContent = "入力必須項目です。";
//         span.className = "error-message";
//       } else {
//         switch (form) {
//           // メールアドレスフォーム
//           case newEmailForm:
//             if (form.value.match(/@/)) {
//               form.className = "success-form";
//               span.textContent = "OK";
//               span.className = "success-message";
//             } else {
//               form.className = "error-form";
//               span.textContent = "入力された値は無効です。";
//               span.className = "error-message";
//             }
//             break
//             // メッセージフォーム
//           case newMessageForm:
//             messageForm(form, span);
//             break
//         }
//       }
//     }

//     // ページ読み込み時にバリデーションチェック
//     for (let i = 0; i < formArray.length; i++) {
//       // フォームに値が入力されているかどうか？
//       let span = document.getElementById(`${formArray[i].id}--notice`);
//       console.log(span, formArray[i])
//       if (formArray[i].value != "") {
//         switch (form) {
//           // emailフォーム
//           case newEmailForm:
//             if (form.value.match(/@/)) {
//               form.className = "success-form";
//               span.textContent = "OK";
//               span.className = "success-message";
//             }
//           break
//           // messageフォーム
//           case newMessageForm:
//             messageForm(form, span);
//             break
//         }
//         if (document.getElementsByClassName("success-message").length === 2) {
//           newContactSubmit.classList.remove("inactive");
//         } else if (newContactSubmit.classList.contains("inactive") == false) {
//           newContactSubmit.classList.add("inactive");
//         }
//       }
//     }


//     // フォーカスアウト時にバリデーションチェック
//     for (let i = 0; i < formArray.length; i++) {
//       formArray[i].addEventListener('focusout', function() {
//         // フォームに値が入力されているかどうか？
//         validation(formArray[i], document.getElementById(`${formArray[i].id}--notice`));
//         if (document.getElementsByClassName("success-message").length === 2) {
//           newContactSubmit.classList.remove("inactive");
//         } else if (newContactSubmit.classList.contains("inactive") == false) {
//           newContactSubmit.classList.add("inactive");
//         }
//       });
//     }

//     // const errorMessages = document.getElementsByClassName("error-messages")[0];
//     // const contactMessageForm = document.getElementById("contact_message");
//     // for (let i = 0; i < errorMessages.childElementCount; i++) {
//     //   let errorMessageText = document.getElementsByClassName("error-message")[i].textContent;
//     //   const commonErrorMessage = "を入力してください"
//     //   console.log(i);

//     //   switch (errorMessageText) {
//     //     case `お問い合わせ内容${commonErrorMessage}`:
//     //       console.log(errorMessageText);
//     //       contactMessageForm.className = "error-form";
//     //       // span.textContent = "半角数字(9桁~11桁)のみご入力ください。";
//     //       // .className = "error-message";
//     //       break
//     //   }
//     // }
//     // switch (errorMessage) {
//     //   case "お問い合わせ内容を入力してください"
//     //     console.log(contactMessageForm);
//     //     break
//     // }
//   }
// });
