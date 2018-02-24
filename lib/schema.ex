defmodule App.Schema do
  use Absinthe.Schema

  object :score do
    field :id, :id
    field :candidate_id, :string
    field :associate_id, :string
    field :question_sets, list_of(:string)
    field :scores_complete, :boolean
    field :updated_at, :string
  end

  query do
    field :scores, list_of(:score) do
      resolve fn _, _ ->
        {time, result} = :timer.tc(fn ->
          {:ok, :erlang.binary_to_term(File.read!("./data"))}
        end)
        IO.inspect("Loaded data file in #{inspect(time / 1000)} ms")
        result
      end
    end
  end

end
