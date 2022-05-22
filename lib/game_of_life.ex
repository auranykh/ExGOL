defmodule GameOfLife do
  @moduledoc """
  Documentation for `GameOfLife`.
  """

  @spec hello :: :world
  @doc """
  Hello world.

  ## Examples

      iex> GameOfLife.hello()
      :world

  """
  def hello do
    :world
  end

  @default_x_size 10
  @default_y_size 10
  @default_percent_alive 0.3
  @wrap_cells :false

  @doc """
  Initialize the game of life with every cell being dead by default.

  ## Examples

        iex> GameOfLife.init(5, 5)
        #Nx.Tensor<
          s64[5][5]
          [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ]
        >

  """
  def init(x_size \\ @default_x_size, y_size \\ @default_y_size) when is_number(x_size) and is_number(y_size) do
    x_size = x_size-1
    y_size = y_size-1
    Enum.map(0..y_size, fn _y -> Enum.map(0..x_size, fn _x -> 0 end) end) |> Nx.tensor(type: :u8)
  end

  @doc """
  Randomly initialize the game of life.
  """
  def randomize(tensor, percent_alive \\ @default_percent_alive) do
    Nx.map(tensor, fn x ->
      cond do
        :rand.uniform <= percent_alive -> Nx.add(x, 1)
        true -> x
      end
    end)
  end

  @doc """
  Runs the game of life for a given number of generations.
  """
  def run(x_size, y_size) do
    init(x_size, y_size)
    |> randomize
  end
end
