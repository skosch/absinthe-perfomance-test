defmodule App do
  def test do
    query_string = """
      query {
        scores {
          id
          candidateId
          associateId
          scoresComplete
          updatedAt
          questionSets
        }
      }
    """

    {time, data} = :timer.tc(fn ->
      :erlang.binary_to_term(File.read!("./data"))
    end)

    IO.inspect("Loaded data file in #{inspect(time / 1000)} ms")

    {time, {:ok, result}} = :timer.tc(fn ->
      Absinthe.run(query_string, App.Schema, root_value: %{data: data})
    end)
    IO.inspect("Ran absinthe query in #{inspect(time / 1000)} ms")

    {time, result} = :timer.tc(fn ->
      Poison.encode!(result)
    end)

    IO.puts("Encoded in #{byte_size(result)} bytes in #{time / 1000}")

  end
end
