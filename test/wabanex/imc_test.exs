defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true
  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      assert {:ok,
              %{
                "Bob" => 50.87907739272994,
                "Jueta" => 21.518367346938778,
                "Log" => 13.242769874834465
              }} == response
    end

    test "when the file does not exists, returns error" do
      params = %{"filename" => "xaxaxa.csv"}

      response = IMC.calculate(params)

      assert {:error, "Error opening the file"} == response
    end
  end
end
