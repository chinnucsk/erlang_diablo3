-module(erlang_diablo3).
-author("Richard Giliam : http://github.com/nirosys").
-version("0.0.1").

-on_load(init/0).

-export([getProfile/1]).

-include("erlang_diablo3.hrl").


init() ->
    case application:start(inets) of
        ok -> ok;
        {error, {already_started, inets}} -> ok;
        Error -> Error
    end.

getProfile(BattleTag) ->
    ApiBattleTag = re:replace(BattleTag, "#", "-", [global, {return, list}]),
    Url = lists:concat(["http://us.battle.net/api/d3/profile/", ApiBattleTag, "/"]),
    case httpc:request(Url) of
        {ok, {_, _, Response}} ->
            #profile{json=Response};
        {error, Reason} ->
            {error, Reason}
    end.
