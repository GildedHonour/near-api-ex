defmodule NearApiTest do
  use ExUnit.Case

  setup do
    {:ok, functions: NearApi.__info__(:functions)}
  end

  describe "NearApi" do
    test "AccessKeys: module contains delegated functions", %{functions: functions} do
      refute functions -- [view_access_key: 3] == functions
      refute functions -- [view_access_key_list: 3] == functions
    end

    test "Accounts: module contains delegated functions", %{functions: functions} do
      refute functions -- [view_account: 2] == functions
    end
  end
end
