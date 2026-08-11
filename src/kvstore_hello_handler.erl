-module(kvstore_hello_handler).

-export([init/2]).

init(Req0, State) ->
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"text/plain">>},
        <<"hello from kvstore">>,
        Req0),
    {ok, Req, State}.