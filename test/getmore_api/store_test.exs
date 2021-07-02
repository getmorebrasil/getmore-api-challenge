defmodule GetmoreApi.StoreTest do
  use GetmoreApi.DataCase

  alias GetmoreApi.Store

  describe "products" do
    test "list_products/1 returns paginated data" do
      params = %{"page" => 3, "page_size" => 5}
      result = Store.list_products(params)
      products = result.data
      page = result.page_number

      assert page == params["page"]
      assert Kernel.length(products) == params["page_size"]
    end
  end
end
