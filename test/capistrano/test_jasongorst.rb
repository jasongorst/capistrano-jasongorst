require "test_helper"

class Capistrano::TestJasongorst < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Capistrano::Jasongorst::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
