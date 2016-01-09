require 'test_helper'
require 'tempfile'

class InvocationTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PStorePP::VERSION
  end

  def test_no_file
    assert_raises do
      PStorePP::CLI.start([])
    end
  end

  def test_non_existing_file
    assert_raises do
      PStorePP::CLI.start('bielefeld')
    end
  end
end
