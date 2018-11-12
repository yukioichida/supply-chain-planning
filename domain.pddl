;Header and description
(define (domain supply-chain)

(:requirements :equality :typing :conditional-effects)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    retail industry
)

(:predicates
    (limit-reached ?i - industry)
    (connected ?i - industry ?r - retail) ; indicates whether a retail is a connection of an industry
)

(:functions 
    (limit ?i - industry)
    (made-items ?i - industry) ; items ready to the replenishment of retails stock
    (stock ?r - retail ?i - industry) ; stock level of a retail given products of an industry
    (demand ?r - retail ?i - industry) ; quantity of demands that a retail should attend
    (monthly-demand ?r - retail ?i - industry); quantity of itens of a industry that a retail sells
    (cost)
)

(:action produce
    :parameters (?i - industry)
    :precondition (and 
                    (not (limit-reached ?i))
                )
    :effect (and 
        (increase (made-items ?i) 1)
        (increase (cost) 1)
        (when   (= (limit ?i) (made-items ?i))
                (limit-reached ?i)
        )
    )
)

(:action replenish-low
    :parameters (?i - industry
                 ?r - retail
                )
    :precondition (and 
                    (> (made-items ?i) 0)
                )
    :effect (and 
                (increase (stock ?r ?i) 1)
                (decrease (made-items ?i) 1)
                (decrease (cost) 1)
                (when   (> (limit ?i) (made-items ?i))
                        (not (limit-reached ?i))
                )
    )
)

(:action replenish-high
    :parameters (?i - industry
                 ?r - retail
                )
    :precondition (and 
                    (>= (made-items ?i) 2)
                )
    :effect (and 
                (increase (stock ?r ?i) 2)
                (decrease (made-items ?i) 2)
                (decrease (cost) 2)
                (when   (> (limit ?i) (made-items ?i))
                        (not (limit-reached ?i))
                )
    )
)

(:action attend-demand
    :parameters (?r - retail
                 ?i - industry)
    :precondition (and 
                        (>= (stock ?r ?i) (monthly-demand ?r ?i))
    )
    :effect (and 
                (decrease (stock ?r ?i) (monthly-demand ?r ?i))
                (increase (demand ?r ?i) 1)
                ;(decrease (cost) 10)
            )
)

)