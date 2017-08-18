require 'test_helper'

class ArchivosControllerTest < ActionDispatch::IntegrationTest
  test "should get cargar_archivos" do
    get archivos_cargar_archivos_url
    assert_response :success
  end

  test "should get listar_archivos" do
    get archivos_listar_archivos_url
    assert_response :success
  end

  test "should get borrar_archivos" do
    get archivos_borrar_archivos_url
    assert_response :success
  end

  test "should get guardar_comentarios" do
    get archivos_guardar_comentarios_url
    assert_response :success
  end

end
