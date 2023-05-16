defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    # answer =
    {:ok, assign(socket, score: 0, message: "Make a guess:", time: time(), answer: Enum.random(1..10))}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1><%= @time %></h1>
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
      <%!-- answer: <%= @answer %> --%>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number= {n} >
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now() |> to_string()
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {message, score} =
      is_correct(String.to_integer(guess), socket.assigns.answer, socket)

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        time: time(),
        answer: Enum.random(1..10)
      )
    }

  end

  def is_correct(guess, answer, socket) when guess == answer do
    {
      "Your guess: #{guess}. Correct!",
      socket.assigns.score + 1
    }
  end

  def is_correct(guess, _, socket) do
    {
      "Your guess: #{guess}. Wrong. Guess again.",
      socket.assigns.score - 1
    }
  end

end
