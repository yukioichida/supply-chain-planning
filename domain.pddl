;Header and description

(define (domain supply-chain)

;remove requirements that are not needed
(:requirements :strips :fluents :typing :conditional-effects :negative-preconditions :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    retail industry
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (connected ?i - industry ?r - retail) ; indicates whether a retail is a connection of a industry
    
)

(:functions ;todo: define numeric functions here
    (stock ?x)
    (order-qty ?i - industry)
)

;define actions here
(:action order
    :parameters (?r - retail
                 ?i - industry
                )
    :precondition (and 
                    (> (stock ?i) 0)
                    (connected ?i ?r)
                )
    :effect (and 
            (decrease (stock ?i) 1)
            (increase (stock ?r) 1)
            )
)

(:action send
    :parameters (
        ?i - industry
        ?r - retail
    )
    :precondition (and )
    :effect (and )
)



)