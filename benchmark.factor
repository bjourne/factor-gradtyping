USING: arrays assocs formatting io.pathnames kernel math math.bits
maybe-typed memory namespaces parser sequences tools.dispatch
tools.memory tools.time words ;

IN: benchmark

CONSTANT: all-names {
    {
        "spectral"
        { "eval-a" "part-A-times-u" "part-At-times-u" }
    }
    {
        "sieve"
        { "sieve" "marked-unsafe?" "unmark-multiples" "unmark"
          "bit-pos" "init-sieve" "upper-bound" }
    }
}

: simple-time ( quot -- )
    [
        [ benchmark ] collect-dispatch-stats last-dispatch-stats set
    ] collect-gc-events gc-events set
    1000000000 /f "%.3f\n" printf ; inline

: set-typing-config ( number words -- )
    [ length <bits> >array ] keep swap zip
    maybe-types set-global ;

: run-bench ( number bench-file -- )
    over "%3d " printf
    [ file-stem all-names at set-typing-config ] keep
    [ run-file ] keep
    gc [
        file-stem "entry" swap lookup-word execute( -- )
    ] simple-time ;
