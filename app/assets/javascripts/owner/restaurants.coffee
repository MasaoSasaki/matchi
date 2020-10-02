# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# 郵便番号から住所自動入力（詳細：https://github.com/ninton/jquery.jpostal.js/）
$ ->
  $("#postal_code-sp, #postal_code-pc").jpostal({
    # 郵便番号の入力欄が１つの場合
    # 111-1111と1111111のどちらの入力形式でも住所を自動入力してくれる
    postcode : [ "#postal_code-sp, #postal_code-pc" ],

    # 郵便番号の入力欄が3桁-4桁で分かれている場合
    # postcode : [ '#zipcode1', '#zipcode2' ]

    address  : {
                  "#restaurant_prefecture" : "%3",
                  "#restaurant_city"            : "%4%5",
                  "#restaurant_street"          : "%6%7"
                }
  })