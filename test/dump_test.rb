require 'test_helper'
require 'tempfile'

class DumpTest < Minitest::Test
  def setup
    @store = create_store(name)
  end

  def teardown
    File.unlink(@store.path)
  end

  def test_single_file
    @store.transaction do
      @store['foo'] = 'bar'
    end

    out, err = capture_io do
      PStorePP::CLI.start(@store.path)
    end

    assert_empty(err)
    assert(out)
    assert_equal({ 'foo' => 'bar' }, JSON.parse(out))
  end

  def test_two_files
    @store.transaction do
      @store['foo'] = 'bar'
    end

    second_store = create_store("#{name}_second_store")
    second_store.transaction do
      second_store['some'] = 'thing'
    end

    out, err = capture_io do
      PStorePP::CLI.start([@store.path, second_store.path])
    end

    assert_empty(err)
    assert(out)

    actual = JSON.parse(out)
    assert_equal(2, actual.size)

    primary = actual.first
    assert(primary)
    assert_equal({ 'foo' => 'bar' }, primary[@store.path])

    secondary = actual.last
    assert(secondary)
    assert_equal({ 'some' => 'thing' }, secondary[second_store.path])
  end

  def create_store(name)
    PStore.new(Tempfile.new(name).path)
  end
end
