module Fluent
  class NetflowMultiplierFilter < Filter
    Plugin.register_filter('netflow_multiplier', self)

  end
end
