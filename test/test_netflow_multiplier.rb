require 'helper'

class TestNetflowMultiplier < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @time = Fluent::Engine.now
  end

  def create_driver(conf = '')
    Fluent::Test::FilterTestDriver.new(Fluent::NetflowMultiplierFilter).configure(conf, true)
  end

  def create_multiplier(conf='')
    Fluent::NetflowMultiplier.new(create_driver(conf).instance)
  end

  def filter(record, conf='')
    driver = create_driver
    driver.run do
      driver.filter record, @time
    end

    driver.filtered_as_array.first[2]
  end

  test 'filter estimates actual counters' do
    driver = create_driver
    record   = {'version' => 9, 'in_bytes' => 1}
    expected = record.merge('in_bytes_estimated' => 1)

    assert_equal expected, filter(record)
  end

  test 'multiplier determines appropriate sampling rate' do
    conf = <<-EOS
      default_sampling_rate 100
      sampling_rate_per_host example/sampling_rate.yml
    EOS

    multiplier = create_multiplier(conf)
    assert_equal  100, multiplier.send(:sampling_rate, {})
    assert_equal  100, multiplier.send(:sampling_rate, 'host' => 'not_defined')
    assert_equal  200, multiplier.send(:sampling_rate, 'sampling_interval' => 200)
    assert_equal  200, multiplier.send(:sampling_rate, 'sampling_interval' => 200, 'host' => '192.168.0.1')
    assert_equal 1000, multiplier.send(:sampling_rate, 'host' => '192.168.0.1')
  end
end
