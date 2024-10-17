defmodule EcoWeb.CustomComponents do
  use Phoenix.Component
  import EcoWeb.CoreComponents, only: [icon: 1]

  def light_bulb(assigns) do
    ~H"""
    <.icon name="hero-star-solid" class={get_color(@color)} />
    """
  end

  defp get_color("P"), do: "text-blue-500"
  defp get_color("G"), do: "text-green-500"
  defp get_color("M"), do: "text-yellow-500"
  defp get_color("B"), do: "text-brown-500"
  defp get_color(_), do: "text-black-500"
end
