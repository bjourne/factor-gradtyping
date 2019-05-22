USING: accessors assocs effects.parser io kernel locals.parser
namespaces typed words ;
IN: maybe-typed

SYMBOL: maybe-types

maybe-types [ H{ } clone ] initialize

: define-maybe-typed ( word def effect -- )
    pick name>> maybe-types get-global at
    [ define-typed ] [ define-declared ] if ;

SYNTAX: T?:
    (:) define-maybe-typed ;
SYNTAX: T?::
    (::) define-maybe-typed ;
