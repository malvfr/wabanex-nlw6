defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller

  alias Wabanex.IMC

  def index(conn, params) do
    params
    |> IMC.calculate()
    |> handle_response(conn)
  end

  def handle_response({:ok, result}, conn) do
    render_response(:ok, result, conn)
  end

  def handle_response({:error, result}, conn) do
    render_response(:bad_request, result, conn)
  end

  def render_response(status, result, conn) do
    conn
    |> put_status(status)
    |> json(%{result: result})
  end
end
