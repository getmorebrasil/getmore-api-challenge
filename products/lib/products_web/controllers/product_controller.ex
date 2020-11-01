defmodule ProductsWeb.ProductController do
    use ProductsWeb, :controller
    alias Products.{ ProductsData,  ProductsData.Product }

  def wait_message(message) when message != [] do
    [_, response] = message
    response == "ok"
  end

  def wait_message(_message) do
    new_message = Rabbitmq.Message.read()
    wait_message(new_message)
  end

    def find(conn, %{"page" => page}) do

      conn
      |> get_req_header("token")
      |> Enum.at(0)
      |> Rabbitmq.Producer.invite_message

      :timer.sleep(5000)

      IO.puts "---get---"
      ok = wait_message(Rabbitmq.Message.read())
      IO.puts ok
      IO.puts "---get---"

      if ok do
        {value, _} = Integer.parse(page)

        products = ProductsData.list_products(value)

        conn
        |> put_status(:ok)
        |> render("products.json", %{products: products})
      else
        conn
        |> put_status(403)
        |> render("error.json", %{error: "Invalid token"})
      end

    end

    def create_all(conn, products ) do
      ProductsData.create_products(products)

      conn
      |> put_status(:created)
      |> render("show-generic-resp.json")

    end

    def create(conn, product) do
      {:ok, %Product{} = product} = ProductsData.create_product(product)

      conn
      |> put_status(:created)
      |> render("show-product.json", %{product: product})

    end
end
