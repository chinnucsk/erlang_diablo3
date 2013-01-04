-module(erlang_diablo3).
-author("Richard Giliam : http://github.com/nirosys").
-version("0.0.1").

-on_load(init/0).

-export([getProfile/1]).


init() ->
    inets:start().


getProfile(BattleTag) ->
    Url = lists:concat(["http://us.battle.net/api/d3/profile/", 
            re:replace(BattleTag,"#","-",[global,{return,list}]), "/"]),
    {ok, {{_Version, 200, _Reason}, _Headers, Body}} =
        httpc:request(get, {Url, []}, [], []),
    Body.
