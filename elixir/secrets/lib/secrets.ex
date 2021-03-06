defmodule Secrets do
  def secret_add(secret), do: fn n -> secret + n end

  def secret_subtract(secret), do: fn n -> n - secret end

  def secret_multiply(secret), do: fn n -> n * secret end

  def secret_divide(secret), do: &trunc(Float.floor(&1 / secret))

  def secret_and(secret), do: &Bitwise.band(&1, secret)

  def secret_xor(secret), do: &Bitwise.bxor(&1, secret)

  def secret_combine(secret_function1, secret_function2),
    do: fn n -> n |> secret_function1.() |> secret_function2.() end
end
