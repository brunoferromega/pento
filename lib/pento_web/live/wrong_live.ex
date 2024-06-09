defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  @right_answer Enum.to_list(1..10) |> Enum.take_random(1) |> hd()

  def time do
    DateTime.utc_now()
    |> to_string()
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:", time: time())}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %> It's time <%= @time %>
    </h2>
    <h2>
      <%= for n <- 1..10  do %>
        <.link href="#" phx-click="guess" phx-value-number={n}>
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {guess, _} = Integer.parse(guess)
    IO.puts("The currently guess: #{guess}")
    IO.puts("The right answer #{@right_answer}")
    answer =
      case guess do
         @right_answer -> {"That't right", 1}
        _ -> {"Your guess: #{guess}. Wrong. Guess again.", -1}
      end

    message = elem(answer, 0)
    score = socket.assigns.score + elem(answer, 1)

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        time: time()
      )
    }
  end
end
