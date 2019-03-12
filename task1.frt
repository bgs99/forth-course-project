: even? 2 % 0 = ;
: max dup rot dup rot > if swap drop else drop then ;
: simple?-stack ( n ) 1 swap dup ( 1 n n ) 2 / 1 + 2 ( 1 n [n/2 + 1] 2 )
    for dup r@ % 0 = if r> drop >r 1 - r@ then endfor drop ;  
: simple? 1 allot ( ADDR ) swap simple?-stack swap dup rot swap c! ;
: strlen 0 swap repeat dup c@ 0 = if 1 else swap 1 + swap 1 + 0 then until drop ;
: strcpy ( addr str -- addr) repeat dup c@ dup 0 = if drop 1 else ( addr str c )
    rot dup rot swap c! ( str addr ) 1 + swap 1 + 0 then until drop ;
: concat ( s1 s2 -- s12 ) dup rot dup rot strlen swap strlen + 1 + heap-alloc
    ( s2 s1 s12addr ) dup rot strcpy ( s2 s12addr s2start ) rot strcpy 0 swap c! ;
: ddiv? ( a b -- [a = k * b * b] ) 
    2dup % 0 = -rot ( r1 a b ) dup -rot / swap % 0 = land ; 
: primary? 1 swap 2 repeat ( res n i ) 2dup ddiv? 
    if rot drop 0 -rot 1 else
       2dup % 0 = if dup -rot / swap then 1 + swap dup 1 = ( res [i+1] n [n=1] )
       -rot swap rot
       then until drop drop ;
