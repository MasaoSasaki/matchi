# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# メニュータグの追加
window.addEventListener 'DOMContentLoaded', ->
  tagForm = document.getElementById("tag_name")
  if tagForm != null
    addTags = ->
      tagName = tagForm.value
      document.getElementById("tag-list").insertAdjacentHTML 'beforeend', "<p class='inline-block add-menu-tag'><span class='menu-tag'>#{tagName} <a>x</a></span></p>"
      document.getElementsByClassName("add-menu-tag")[0].insertAdjacentHTML 'beforeend', "<input type='hidden' value='#{tagName}' name='tag[]'></input>"
      tagForm.value = ""

    # // エンターキーを押して追加
    tagForm.addEventListener 'keypress', (key) ->
      if key.which == 13
        addTags()

    # // 追加ボタンを押して追加
    document.getElementsByClassName("add-tag-btn")[0].addEventListener 'click', ->
      addTags()
