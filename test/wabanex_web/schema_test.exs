defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.Users.Create
  alias Wabanex.User

  describe "users queries" do
    test "when a valid ID is given, returns the user", %{conn: conn} do
      params = %{email: "aa@aa.com", name: "Rafa", password: "12312312"}

      {ok, %User{id: user_id}} = Create.call(params)

      query = """
      query {
        getUser(id: "#{user_id}") {
          email
          id
          name
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "getUser" => %{
                   "email" => "aa@aa.com",
                   "id" => user_id,
                   "name" => "Rafa"
                 }
               }
             } == response
    end
  end

  describe "user mutations" do
    test "whenn all params are valid, creates user", %{conn: conn} do
      mutation = """
      mutation {
        createUser(input: {name: "jafus", password: "!123123123" ,email: "dasdas@"}) {
          id
          name
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createUser" => %{
                   "id" => _id,
                   "name" => "jafus"
                 }
               }
             } = response
    end
  end
end
