USING: byte-arrays kernel locals math
math.bitwise math.functions math.ranges
maybe-typed sequences ;
IN: sieve

CONSTANT: masks
{ f 128 f f f f f 64  f f f 32
  f 16 f f f 8 f 4 f f f 2 f f f f f 1 }
T?: bit-pos (
    n: fixnum --
    byte: fixnum mask/f: maybe{ fixnum } )
    30 /mod masks nth ;
T?:: marked? (
    n: fixnum sv: byte-array -- ?: boolean )
    n bit-pos [
        [ sv nth ] [ mask zero? not ] bi*
    ] [ drop f ] if* ;
T?:: unmark ( n: fixnum sv: byte-array -- )
    n bit-pos [
        swap sv [ swap unmask ] change-nth
    ] [ drop ] if* ;
T?: u-bound ( sv: byte-array -- n: fixnum )
    length 30 * 1 - ;
T?: init-sieve ( n: fixnum -- sv: byte-array )
    30 /i 1 + [ 255 ] B{ } replicate-as ;
T?:: unmark-mults (
    i: fixnum upper: fixnum sv: byte-array -- )
    i 2 * :> step
    i i *
    [ dup upper <= ] [
        [ sv unmark ] [ step + ] bi
    ] while drop ;
T?:: sieve ( n: fixnum -- sieve: byte-array )
    n integer>fixnum-strict init-sieve :> sv
    sv u-bound >fixnum :> upper
    3 upper sqrt 2 <range> [| i |
        i sv marked? [
            i upper sv unmark-mults
        ] when
    ] each sv ;
: entry ( -- ) 100,000,000 sieve drop ;
