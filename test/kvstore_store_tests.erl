%%%-------------------------------------------------------------------
%%% @author fxsclow
%%% @copyright (C) 2026, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. Aug 2026 16:40
%%%-------------------------------------------------------------------
-module(kvstore_store_tests).
-author("fxsclow").
-include_lib("eunit/include/eunit.hrl").


set_and_get() ->
  kvstore_store:set(<<"testKey">>, <<"testValue">>),
  ?assertEqual({ok, <<"testValue">>}, kvstore_store:get(<<"testKey">>)).

get_missing_key() ->
  ?assertEqual({error, not_found},   kvstore_store:get(<<"missing">>)).

delete_and_get() ->
  kvstore_store:set(<<"testKeyToDelete">>, <<"testValueToDelete">>),
  kvstore_store:delete(<<"testKeyToDelete">>),
  ?assertEqual({error, not_found},   kvstore_store:get(<<"testKeyToDelete">>)).

setup() ->
  {ok, Pid} = kvstore_store:start_link(),
  Pid.

cleanup(Pid) ->
  gen_server:stop(Pid).

kvstore_store_test_() ->
  {setup,
    fun setup/0,
    fun cleanup/1,
    [
      fun() -> set_and_get() end,
      fun() -> get_missing_key() end,
      fun() -> delete_and_get() end
    ]}.