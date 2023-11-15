defmodule MyApp do
  def enemy_defeated do
    player = %{id: 1, name: "Hunter"}

    :telemetry.execute([:distributed_log_v3, :player, :enemy_defeated], %{count: 1}, %{player: player})
  end

  def gold_collected(value) do
    player = %{id: 1, name: "Hunter"}

    :telemetry.execute([:distributed_log_v3, :player, :gold_collected], %{value: value}, %{player: player})
  end
end
