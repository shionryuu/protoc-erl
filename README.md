# protoc-erl

[![Build Status](https://secure.travis-ci.org/ShionRyuu/protoc-erl.png?branch=master)](http://travis-ci.org/ShionRyuu/protoc-erl)

Escript used to generate erlang protobuf

## Usage

```sh
$ ./protoc-erl ./proto ./ebin ./include

=INFO REPORT==== 26-Dec-2015::01:08:02 ===
Writing header file to "./include/simple_pb.hrl"

=INFO REPORT==== 26-Dec-2015::01:08:03 ===
Writing beam file to "./ebin/simple_pb.beam"
```

## Authors

- Shion Ryuu <shionryuu@outlook.com>

## License

[`The MIT License (MIT)`](http://shionryuu.mit-license.org/)
  
## Update
  
As rebar already support src_dirs option, this repository is no longer needed.
