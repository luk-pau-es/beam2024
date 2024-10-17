defmodule EcoWeb.IndexLive do
  alias Phoenix.PubSub
  use EcoWeb, :live_view

  alias EcoWeb.LiveComponents.SignComponent

  def mount(_parmas, _session, socket) do
    PubSub.subscribe(Eco.PubSub, "recyclables")

    socket =
      socket
      |> assign(:form, to_form(%{}))
      |> assign(:P, 1)
      |> assign(:G, 1)
      |> assign(:M, 1)
      |> assign(:B, 1)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-5xl font-extrabold">Let's sort some rubbish!!</h1>
    <p>
      Please provide a string consisting of the letters P(Paper), G(Glass), M(Metal) and B(Bio) (e.g., PPGMB), case-insensitive.
    </p>
    <.simple_form for={@form} phx-submit="save">
      <.input field={@form[:sequence]} label="Sequence" />
      <:actions>
        <.button>Submit</.button>
      </:actions>
    </.simple_form>
    <div class="grid grid-cols-2 grid-rows-2 gap-4">
      <%= for sign <- ["P", "G", "M", "B"] do %>
        <.live_component
          module={SignComponent}
          id={sign}
          sign={sign}
          amount={assigns[String.to_existing_atom(sign)]}
        />
      <% end %>
    </div>
    """
  end

  def handle_event("save", %{"sequence" => _sequence}, socket) do
    {:noreply, socket}
  end

  def handle_info({:recycled, sign}, socket) do
    key = String.to_existing_atom(sign)
    current_sign_amount = socket.assigns[key]
    {:noreply, assign(socket, key, current_sign_amount + 1)}
  end
end
