defmodule EcoWeb.LiveComponents.SignComponent do
  use EcoWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <h2 class="text-4xl font-bold"><%= sign_to_name(@sign) %></h2>
      <p>Counter: <%= @amount %></p>
      <.light_bulb :for={_i <- 1..@amount} :if={@amount > 0} color={@sign} />
    </div>
    """
  end

  defp sign_to_name("P"), do: "Paper"
  defp sign_to_name("G"), do: "Glass"
  defp sign_to_name("M"), do: "Metal"
  defp sign_to_name("B"), do: "Bio"
  defp sign_to_name(_), do: "Unknown"
end
