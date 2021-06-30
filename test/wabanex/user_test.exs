defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true
  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "bob", email: "froog@email.com", password: "123123"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{email: "froog@email.com", name: "bob", password: "123123"},
               errors: []
             } = response
    end

    test "when all params are invalid, returns an invalid changeset" do
      params = %{name: "bob", email: "froog", password: "123123"}

      response = User.changeset(params)

      assert errors_on(response) == %{email: ["has invalid format"]}
    end
  end
end
