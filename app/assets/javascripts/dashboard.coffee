# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



activate = (tipo) ->
  if tipo == "todos"
    $("#todos")[0].style.display = 'block'
  else if tipo == "recepcion"
    $("#recepcion")[0].style.display = 'block'
  else if tipo == "despacho"
    $("#despacho")[0].style.display = 'block'
  else if tipo == "pulmon"
    $("#pulmon")[0].style.display = 'block'
  else if tipo == "libre"
    $("#libre")[0].style.display = 'block'

deactivate = () ->
  $(".active")[0].className = "btn btn-primary inactive"
  $("#todos")[0].style.display = "none"
  $("#recepcion")[0].style.display = "none"
  $("#pulmon")[0].style.display = "none"
  $("#libre")[0].style.display = "none"
  $("#despacho")[0].style.display = "none"

$ ->
  $("#boton_todos").click (e) ->
    e.preventDefault()
    deactivate()
    this.className = "btn btn-primary active"
    activate("todos")

$ ->
  $("#boton_despacho").click (e) ->
    e.preventDefault()
    deactivate()
    this.className = "btn btn-primary active"
    activate("despacho")

$ ->
  $("#boton_recepcion").click (e) ->
    e.preventDefault()
    deactivate()
    this.className = "btn btn-primary active"
    activate("recepcion")

$ ->
  $("#boton_libre").click (e) ->
    e.preventDefault()
    deactivate()
    this.className = "btn btn-primary active"
    activate("libre")

$ ->
  $("#boton_pulmon").click (e) ->
    e.preventDefault()
    deactivate()
    this.className = "btn btn-primary active"
    activate("pulmon")