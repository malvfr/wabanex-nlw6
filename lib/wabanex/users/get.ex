defmodule Wabanex.Users.Get do
  alias Wabanex.{Repo, User}

  def call(uuid) do
    uuid
    |> Ecto.UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error) do
    {:error, "Invalid UUID"}
  end

  defp handle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
