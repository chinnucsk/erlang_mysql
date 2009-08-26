#!/usr/bin/env escript
%% -*- erlang -*-
%%! -pa ./ebin -boot start_sasl -sasl sasl_error_logger false

main(_) ->
    etap:plan(unknown),
    crypto:start(),
    {Host, User, Pass, Name} = {"localhost", "test", "test", "testdatabase"},

    process_flag(trap_exit, true),
    etap:is((catch mysql:start_link(test1, Host, 3305, User, Pass, Name, 'utf8')), {error, connect_failed}, "invalid server"),
    process_flag(trap_exit, false),

    {ok, Pid} = mysql:start_link(test1, Host, 3306, User, Pass, Name, 'utf8'),
    etap:ok(is_process_alive(Pid), "MySQL gen_server running"),
    X = mysql:connect(test1, Host, 3306, User, Pass, Name, 'utf8'),
    etap:end_tests().
