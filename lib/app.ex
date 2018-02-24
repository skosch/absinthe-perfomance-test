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

    {time, _result} = :timer.tc(fn ->
      Absinthe.run(query_string, App.Schema)
    end)

    IO.inspect("Ran absinthe query in #{inspect(time / 1000)} ms")
  end
end
