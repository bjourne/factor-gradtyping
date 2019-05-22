USING: arrays fry kernel locals math maybe-typed
sequences ;
IN: spectral

T?:: eval-a ( i: float j: float --
                  z: float )
    i j + i j + 1 + * 2 /i i + 1 + recip ;
T?:: part-A-times-u ( i: float u: array --
                          sum: float )
    u [ i swap eval-a * ] map-index sum ;
T?:: part-At-times-u ( i: float u: array --
                           sum: float )
    u [ i eval-a * ] map-index sum ;
:: benchmark-spectral-norm ( loops def-n -- )
    loops [
        10 <iota>
        def-n 1.0 <array> '[
            _
            [ part-A-times-u ]
            [ part-At-times-u ] 2bi 2drop
        ] each
    ] times ;
: entry ( -- )
    100 50,000 benchmark-spectral-norm ;
