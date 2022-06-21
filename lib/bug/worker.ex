defmodule Bug.Worker do
  use Oban.Worker, max_attempts: 1

  @impl Oban.Worker
  def perform(%Oban.Job{}) do
    {:discard, "sorry"}
  end
end
