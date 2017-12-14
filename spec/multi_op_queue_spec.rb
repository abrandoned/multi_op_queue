require 'spec_helper'

describe ::MultiOpQueue::Queue do
  before do
    @queue = ::MultiOpQueue::Queue.new
  end

  describe "#concat" do
    it "pushes all of the array elements onto the queue" do
      @queue.concat([1, 2, 3])
      @queue.size.must_equal 3
    end

    it "keeps the order for pop of the array" do
      @queue.concat([1, 2, 3])
      @queue.pop.must_equal 1
      @queue.pop.must_equal 2
      @queue.pop.must_equal 3
    end
  end

  describe "#size" do
    it "returns 0 when queue is empty" do
      @queue.size.must_equal 0
    end

    it "returns the number of items present when queue is not empty" do
      @queue.push(1)
      @queue.push(1)
      @queue.push(1)
      @queue.push(1)
      @queue.push(1)
      @queue.size.must_equal 5
    end
  end

  describe "#pop_up_to" do
    it "returns an array of 1 element when 1 element present" do
      @queue.push(1)
      @queue.pop_up_to.must_equal [1]
    end

    it "returns an array of the pop_up_to number when present" do
      @queue.push(1)
      @queue.push(1)
      @queue.push(1)
      @queue.push(1)
      @queue.push(1)

      @queue.pop_up_to(3).must_equal [1, 1, 1]
    end

    it "supports an optional timeout" do
      start = Time.now.to_f
      @queue.pop_up_to(5, timeout: 0.1).must_be_nil
      (Time.now.to_f - start).must_be_within_delta(0.1, 0.01)
    end

    it "blocks until items are available" do
      start = Time.now.to_f
      Thread.new { sleep 0.1; @queue.push(3) }
      @queue.pop_up_to(5, timeout: 0.5).must_equal [3]
      (Time.now.to_f - start).must_be_within_delta(0.1, 0.01)
    end
  end
end
