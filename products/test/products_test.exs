defmodule ProductsTest do
  @moduledoc false
  use Products.DataCase, async: true

  import Products.Factory

  describe "list/1" do
    test "When has not params, return products with default pagination" do
      # Arrange
      [%{id: first_id} | _] = insert_list(30, :product)

      # Act
      [%{id: id} | _] = response = Products.list()

      # Assert
      assert length(response) == 20
      assert first_id == id
    end

    test "When has page size param, return page size products quantity" do
      # Arrange
      [%{id: first_id} | _] = insert_list(10, :product)
      params = %{"page_size" => 2}

      # Act
      [%{id: id} | _] = response = Products.list(params)

      # Assert
      assert length(response) == 2
      assert first_id == id
    end

    test "When has page param, return correct page products" do
      # Arrange
      [%{id: first_id} | _] = insert_list(30, :product)
      params = %{"page" => 2}
      first_page_id = first_id + 20

      # Act
      [%{id: id} | _] = response = Products.list(params)

      # Assert
      assert first_page_id == id
    end
  end
end
