defmodule Bug.WorkerTest do
  use Bug.DataCase
  use Oban.Testing, repo: Bug.Repo

  test "discarded job is processed successfully" do
    assert %{}
           |> Bug.Worker.new()
           |> Oban.insert!()
  end
end
