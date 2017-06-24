defmodule Micro.PostText do
  use ExUnit.Case, async: true

  alias Micro.Post

  @required_attributes %{
    content: Faker.Lorem.sentence()
  }

  describe "changeset" do
    test "changeset without the required attributes" do
      changeset = Post.changeset(%Post{}, %{})
      refute changeset.valid?
    end

    test "changeset with required attributes" do
      changeset = Post.changeset(%Post{}, @required_attributes)
      assert changeset.valid?
    end
  end
end
