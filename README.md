# fluent-plugin-netflow-multipler

[![Test on Ubuntu](https://github.com/codeout/fluent-plugin-netflow-multiplier/actions/workflows/test-linux.yaml/badge.svg)](https://github.com/codeout/fluent-plugin-netflow-multiplier/actions/workflows/test-linux.yaml)

## Overview

Fluentd filter plugin to multiply sampled netflow counters by sampling rate.

Netflow exporters usually export netflow data after sampling with specific rate and collectors need to multiply the data by the sampling rate to estimate actual values. This netflow filter plugin finds counters and sampling rate field in each netflow and calculate into other counter fields. Default or exporter-specific sampling rate will be used if no sampling rate found in netflow data.

**NOTE**

Netflow v10 (a.k.a. IPFIX) is not tested.

## Installation

Use ```td-agent-gem``` or ```fluent-gem```:

```zsh
$ td-agent-gem install fluent-plugin-netflow-multiplier
$ fluent-gem install fluent-plugin-netflow-multiplier
```

Or you can use native ```gem``` as well:

```zsh
$ gem install fluent-plugin-netflow-multiplier
```

## Configuration

This is an example to configure this plugin in conjunction with [fluent-plugin-netflow](https://github.com/repeatedly/fluent-plugin-netflow) as input plugin, and stdout as output plugin.

```
<source>
  @type netflow
  bind 0.0.0.0
  port 2055
  tag  netflow.event
</source>

<filter netflow.event>
  @type netflow_multiplier
  default_sampling_rate 10000
</filter>

<match netflow.event>
  @type stdout
</match>
```

### Parameters

**default_sampling_rate**

Default sampling rate.  
(Default: 1)

**sampling_rate_per_host**

Path to sampling rate definition file which describe per-host rates. The definition file should be in YAML like [this](example/sampling_rate.yml).  
(Default: nil)

**record_suffix**

Field suffix for mutiplied values. This plugin calculates the values from original fields and stores into other fields appended the suffix. (eg: ```in_bytes``` into ```in_bytes_estimated```)  
(Default: '_estimated')

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/codeout/fluent-plugin-netflow-multiplier.

## Copyright and License

Copyright (c) 2016-2021 Shintaro Kojima. Code released under the [Apache License, Version 2.0](LICENSE).
