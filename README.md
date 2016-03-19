# fluent-plugin-netflow-multipler

## Overview

Fluentd filter plugin to multiply sampled netflow counters by sampling rate.

Netflow exporters usually export netflow data after sampling with specific rate and collectors need to multiply the data by the sampling rate to estimate actual values. This netflow filter plugin finds counters and sampling rate field in each netflow and calculate into other counter fields. Default or exporter-specific sampling rate will be used if no sampling rate found in netflow data.

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

TODO: Write something

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/codeout/fluent-plugin-netflow-multiplier.

## Copyright and License

Copyright (c) 2016 Shintaro Kojima. Code released under the [Apache License, Version 2.0](LICENSE).
