defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, returns the imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      assert %{
               "result" => %{
                 "Bob" => 50.87907739272994,
                 "Jueta" => 21.518367346938778,
                 "Log" => 13.242769874834465
               }
             } == response
    end

    test "when  params are invalid, returns error 400", %{conn: conn} do
      params = %{"filename" => "xaxa.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      assert %{"result" => "Error opening the file"} == response
    end
  end
end
