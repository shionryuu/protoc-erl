%% -------------------------------------------------------------------
%% protoc-erl: a wrapper for erlang-protobuffs
%%
%% Copyright (c) 2015 Shion Ryuu (shionryuu@outlook.com)
%%
%% Permission is hereby granted, free of charge, to any person obtaining a copy
%% of this software and associated documentation files (the "Software"), to deal
%% in the Software without restriction, including without limitation the rights
%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%% copies of the Software, and to permit persons to whom the Software is
%% furnished to do so, subject to the following conditions:
%%
%% The above copyright notice and this permission notice shall be included in
%% all copies or substantial portions of the Software.
%%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
%% THE SOFTWARE.
%% -------------------------------------------------------------------
-module('protoc-erl').
-author("Ryuu").

%% API
-export([
    main/1,
    help/0,
    generate/3,
    generate_all/3
]).

%% @doc escript entry
main([ProtoPath, EbinOutput, IncludeOutput])->
    generate_all(ProtoPath, EbinOutput, IncludeOutput);
main(_)->
    help().

%% @doc help message
help() ->
    io:format("usage:~n"),
    io:format("  ~s proto_path ebin_path include_path~n", [filename:basename(escript:script_name())]),
    ok.

%% @doc generate protos
generate_all(ProtoPath, EbinOutput, IncludeOutput) ->
    Options = [
        {output_include_dir, IncludeOutput},
        {output_ebin_dir, EbinOutput}
    ],
    AbsPath = filename:absname(ProtoPath),
    ProtoList = filelib:wildcard("*.proto", AbsPath),
    generate(ProtoList, AbsPath, Options).

generate([], _ProtoPath, _Options) ->
    ok;
generate([File | Next], ProtoPath, Options) ->
    FullName = filename:join([ProtoPath, File]),
    case generate_file(FullName, Options) of
        ok ->
            generate(Next, ProtoPath, Options);
        {error, Reason} ->
            error_logger:error_msg("failed to generate proto ~w, error ~w", [File, Reason]),
            {error, Reason}
    end.

%% @doc generate single proto file
generate_file(ProtoFile, Options) ->
    protobuffs_compile:scan_file(ProtoFile, Options).
