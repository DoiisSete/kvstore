%%%-------------------------------------------------------------------
%%% @author fxsclow
%%% @copyright (C) 2026, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Aug 2026 15:34
%%%-------------------------------------------------------------------
-module(kvstore_key_handler).
-author("fxsclow").

%% API
-export([init/2]).

init(Req0, State) ->
  Method = cowboy_req:method(Req0),
  Key = cowboy_req:binding(key, Req0),
  Req = handle_method(Method, Key, Req0),
  {ok, Req, State}.

handle_method(<<"GET">>, Key, Req0) ->
  case kvstore_store:get(Key) of
    {ok, Value} ->
      Body = <<Key/binary, ": ", Value/binary>>,
      cowboy_req:reply(200,
        #{<<"content-type">> => <<"text/plain">>},
        Body,
        Req0);
    {error, not_found} ->
      cowboy_req:reply(404,
        #{<<"content-type">> => <<"text/plain">>},
        <<"key not found">>,
        Req0)
  end;

handle_method(<<"PUT">>, Key, Req0) ->
  {ok, Body, Req1} = cowboy_req:read_body(Req0),
  ok = kvstore_store:set(Key, Body),
  cowboy_req:reply(200, #{}, <<"ok">>, Req1);

handle_method(<<"DELETE">>, Key, Req0) ->
  ok = kvstore_store:delete(Key),
  cowboy_req:reply(200, #{}, <<"ok">>, Req0).
