defmodule DistributedLogV3.PromExPlugin do
    use PromEx.Plugin

    @player_enemy_defeated_event [:distributed_log_v3, :player, :enemy_defeated]
    @player_gold_collected_event [:distributed_log_v3, :player, :gold_collected]

    @impl true
    def event_metrics(_opts) do   
      [
        player_general_event_metrics()
      ]
    end

    defp player_general_event_metrics do
      Event.build(
        :distributed_log_v3_player_general_event_metrics,
        [
          counter(
            @player_enemy_defeated_event ++ [:count],
            event_name: @player_enemy_defeated_event,
            description: "The number of enemy defeated events that have occurred",
            tags: [:player_id, :player_name],
            tag_values: &get_player_tag_values/1
          ),
          sum(
            @player_gold_collected_event ++ [:value],
            event_name: @player_gold_collected_event,
            description: "The total gold collected by the player",
            tags: [:player_id, :player_name],
            tag_values: &get_player_tag_values/1
          )
        ]
      )
    end

    defp get_player_tag_values(%{player: %{id: id, name: name}}) do
      %{player_id: id, player_name: name}
    end 
end
