require 'fluent/config/error'
require 'yaml'

module Fluent
  class NetflowMultiplier
    attr_accessor :log

    FIELDS_TO_MULTIPLY = %w[
        in_pkts in_bytes
        flows mul_dst_pkts mul_dst_bytes out_bytes out_pkts total_bytes_exp total_pkts_exp total_flows_exp
    ]

    def initialize(plugin)
      @log                    = plugin.log
      @default_sampling_rate  = plugin.default_sampling_rate
      @sampling_rate_per_host = plugin.sampling_rate_per_host
      @record_suffix          = plugin.record_suffix

      @sampling_rate = {}
      if @sampling_rate_per_host
        unless File.exist?(@sampling_rate_per_host)
          raise ConfigError, "sampling rate definition '#{@sampling_rate_per_host}' not found"
        end

        begin
          @sampling_rate = YAML.load_file(@sampling_rate_per_host)
        rescue => e
          raise ConfigError, "Bad syntax in yaml '#{@sampling_rate_per_host}', error_class = #{e.class.name}, error = #{e.message}"
        end
      end

      @estimated_fields = FIELDS_TO_MULTIPLY.map {|f| [f, f + @record_suffix] }.to_h
    end

    def multiply(record)
      rate = sampling_rate(record)

      @estimated_fields.each do |original, estimated|
        record[estimated] = record[original].to_i * rate if record[original]
      end

      record
    end


    private

    SAMPLING_RATE_FIELD = 'sampling_interval'
    HOST_FIELD          = 'host'

    def sampling_rate(record)
      return record[SAMPLING_RATE_FIELD].to_i if record[SAMPLING_RATE_FIELD]
      @sampling_rate[record[HOST_FIELD]] || @default_sampling_rate
    end
  end
end
