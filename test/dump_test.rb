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
      PStorePP::CLI.new.start(@store.path)
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
      PStorePP::CLI.new.start([@store.path, second_store.path])
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

  def test_custom_library
    path = 'test/fixtures/test_custom_library.pstore'

    # the fixture was created with
    # create_store_with_uri(path)
    store = PStore.new(path)

    # ensure URI is not present (may have been required by another test that
    # was running before this)
    Object.send(:remove_const, :URI) if Object.constants.include?(:URI)

    assert_raises ArgumentError do
      PStorePP::CLI.new.start(store.path)
    end
  end

  def test_require_custom_library
    store = PStore.new('test/fixtures/test_custom_library.pstore')

    # ensure URI is not present (was not required by another test)
    refute Object.constants.include?(:URI)

    out, err = capture_io do
      PStorePP::CLI.new('uri').start(store.path)
    end

    assert_empty(err)
    assert(out)
    assert_equal({ 'uri' => 'http://example.com' }, JSON.parse(out))
  end

  def create_store(name)
    PStore.new(Tempfile.new(name).path)
  end

  def create_store_with_uri(path)
    require 'uri'
    store = PStore.new(path)

    store.transaction do
      store['uri'] = URI('http://example.com')
    end

    store
  end
end
