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
      resolve fn root, _, _ ->
        {:ok, root.data}
      end
    end
  end

end
