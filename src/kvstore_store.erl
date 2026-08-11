%%%-------------------------------------------------------------------
%%% @author fxsclow
%%% @copyright (C) 2026, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. Aug 2026 15:43
%%%-------------------------------------------------------------------
-module(kvstore_store).

-behaviour(gen_server).

-export([start_link/0, get/1, set/2, delete/1]).

-export([init/1, handle_call/3, handle_cast/2]).

-define(TABLE, kvstore_table).

%% API
start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

get(Key) ->
  case ets:lookup(?TABLE, Key) of
    [{Key, Value}] -> {ok, Value};
    [] -> {error, not_found}
  end.

set(Key, Value) ->
  ets:insert(?TABLE, {Key, Value}),
  ok.

delete(Key) ->
  ets:delete(?TABLE, Key),
  ok.

init([]) ->
  ets:new(?TABLE, [set, public, named_table]),
  {ok, #{}}.

handle_call(_Request, _From, State) ->
  {reply, ok, State}.

handle_cast(_Msg, State) ->
  {noreply, State}.