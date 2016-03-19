module Fluent
  class NetflowMultiplierFilter < Filter
    Plugin.register_filter('netflow_multiplier', self)

    config_param :default_sampling_rate, :integer, default: 1,
                 desc: 'Default sampling rate'
    config_param :sampling_rate_per_host, :string, default: nil,
                 desc: 'Path to sampling rate definition file which describe per-host rates'
    config_param :record_suffix, :string, default: '_estimated',
                 desc: 'Field suffix for mutiplied values'

    def initialize
      super
      require 'fluent/plugin/netflow_multiplier'
    end

    def configure(conf)
      super
      @multiplier = NetflowMultiplier.new(self)
    end

    def filter(tag, time, record)
      @multiplier.multiply(record)
    end
  end
end
