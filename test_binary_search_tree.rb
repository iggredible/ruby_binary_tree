require "minitest/autorun"
require "./binary_search_tree"
require "byebug"

describe BinarySearchTree do
  describe "#insert!" do
    before do
      @bst = BinarySearchTree.new
      @bst.insert!(value: 1)
    end

    describe "when root is nil" do
      it "creates a new tree node" do
        assert_equal @bst.root.value, 1
      end

      it "increments the size by 1" do
        assert_equal @bst.size, 1    
      end
    end

    describe "when root exists" do
      before do
        @bst = BinarySearchTree.new
        @bst.insert!(value: 10)
      end

      describe "when value is less than root value" do
        it "creates a new left node" do
          @bst.insert!(value: 5)
          assert_equal @bst.root.left.value, 5
          assert_equal @bst.size, 2
        end
      end

      describe "When value is greater than root value" do
        it "creates a new right node" do
          @bst.insert!(value: 15)
          assert_equal @bst.root.right.value, 15
          assert_equal @bst.size, 2
        end
      end
    end
  end

  describe "#size" do
    it "sums the nodes" do
      bst = BinarySearchTree.new
      bst.insert!(value: 1)
      bst.insert!(value: 5)
      assert_equal(bst.size, 2)
    end
  end

  describe "reset" do
    it "resets the bst" do
      bst = BinarySearchTree.new
      bst.insert!(value: 1)
      bst.reset!
      assert_equal bst.size, 0
      assert_nil bst.root
    end
  end

  describe "#contains?" do
    before do
      @bst = BinarySearchTree.new
      @bst.insert!(value: 10)
      @bst.insert!(value: 5)
    end

    describe "when a node in BST contains the given value" do
      it "returns true" do
        assert_equal @bst.contains?(value: 10), true
        assert_equal @bst.contains?(value: 5), true
      end
    end

    describe "when no node in BST contains the given value" do
      it "returns false" do
        assert_equal @bst.contains?(value: 77), false
      end
    end
  end

  describe "#max" do
    it "returns a max value" do
      bst = BinarySearchTree.new
      [5, 10, 15, 100].each do |num|
        bst.insert!(value: num)
      end

      assert_equal bst.max.value, 100
    end
  end

  describe "#min" do
    it "returns a min value" do
      bst = BinarySearchTree.new
      [100, 15, 10, 5].each do |num|
        bst.insert!(value: num)
      end

      assert_equal bst.min.value, 5
    end
  end

  describe "#remove" do
    describe "when there is no existing node" do
      it "does nothing" do
        bst = BinarySearchTree.new
        assert_nil bst.remove!(value: 10)
      end
    end

    describe "when node has zero child" do
      describe "when no value matches" do
        it "does nothing" do
          bst = BinarySearchTree.new
          bst.insert!(value: 10)
          current_size = bst.size
          bst.remove!(value: 77)
          assert_equal(current_size, bst.size)
        end
      end

      describe "when value matches" do
        it "removes the node" do
          bst = BinarySearchTree.new
          bst.insert!(value: 10)
          current_size = bst.size
          bst.remove!(value: 10)
          assert_equal current_size, 1
          assert_equal bst.size, 0
        end
      end
    end

    describe "when node has two children" do
      it "removes the node and promotes the largest data on the left subtree to its position" do
        bst = BinarySearchTree.new
        bst.insert!(value: 10)
        bst.insert!(value: 5)

        bst.insert!(value: 15)
        bst.insert!(value: 12)
        bst.insert!(value: 13)
        bst.insert!(value: 16)
        bst.insert!(value: 20)

        current_size = bst.size
        assert_equal current_size, 7
        assert_equal([bst.root.right.left, bst.root.right.right].compact.length, 2) # ensure the node-about-to-be-removed has two children
        bst.remove!(value: 15)
        assert_equal bst.root.right.value, 12
      end
    end

    describe "when node has one child" do
      it "removes the node and promotes its child to its position" do
        bst = BinarySearchTree.new
        bst.insert!(value: 10) # root

        bst.insert!(value: 5) # root.left

        bst.insert!(value: 15) # root.right
        bst.insert!(value: 12) # root.right.left
        bst.insert!(value: 11) # root.right.left.left

        current_size = bst.size
        assert_equal current_size, 5
        assert_equal([bst.root.right.left, bst.root.right.right].compact.length, 1) # ensure the node-about-to-be-removed has one child
        bst.remove!(value: 15)
        assert_equal 12, bst.root.right.value
      end
    end
  end
end
