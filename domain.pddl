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
    (max-capacity ?i - industry)
    (total-orders ?i - industry)
    (received-orders ?i - industry ?r - retail)
    (made-items ?i - industry) ; items ready to the replenishment of retails stock
    (stock ?r - retail ?i - industry) ; stock level of a retail given products of an industry
    (demand ?r - retail ?i - industry) ; quantity of demands that a retail should attend
    (monthly-demand ?r - retail ?i - industry); quantity of itens of a industry that a retail sells
    (total-cost)
)

; =================== PRODUCE ===============================

(:action produce-low
    :parameters (?i - industry)
    :precondition (and 
                    (not (limit-reached ?i)) ; verify the limit
                    (>= (total-orders ?i) 1) ; produce only if have orders
                    (< (made-items ?i) (limit ?i)) ; verify if this produce will reach the limit
                )
    :effect (and 
        (increase (made-items ?i) 1)
        (increase (total-cost) 1)
        (when   (= (limit ?i) (made-items ?i))
                (limit-reached ?i)
        )
    )
)

(:action produce-high
    :parameters (?i - industry)
    :precondition (and 
                    (not (limit-reached ?i))
                    (>= (total-orders ?i) (max-capacity ?i))
                    (< (made-items ?i) (- (limit ?i) (max-capacity ?i)))
                )
    :effect (and 
        (increase (total-cost) (max-capacity ?i))
        (increase (made-items ?i) (max-capacity ?i))
        (when   (= (limit ?i) (made-items ?i))
                (limit-reached ?i)
        )
    )
)

; =================== REPLENISH ===============================

(:action replenish-low
    :parameters (?i - industry
                 ?r - retail
                )
    :precondition (and 
                    (> (made-items ?i) 0)
                    (>= (received-orders ?i ?r) 1)
                )
    :effect (and 
                (increase (stock ?r ?i) 1)
                (increase (total-cost) 2)
                (decrease (made-items ?i) 1)
                (decrease (received-orders ?i ?r) 1)
                (decrease (total-orders ?i) 1)
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
                    (>= (made-items ?i) (max-capacity ?i))
                    (>= (received-orders ?i ?r) (max-capacity ?i))
                )
    :effect (and 
                (increase (stock ?r ?i) (max-capacity ?i))
                (increase (total-cost) 1)
                (decrease (made-items ?i) (max-capacity ?i))
                (decrease (received-orders ?i ?r) (max-capacity ?i))
                (decrease (total-orders ?i) (max-capacity ?i))
                (when   (> (limit ?i) (made-items ?i))
                        (not (limit-reached ?i))
                )
    )
)

; =================== ORDER ===============================

(:action order-low
    :parameters (?r - retail ?i - industry)
    :precondition (and 
                        (connected ?i ?r)
    )
    :effect (and 
                (increase (received-orders ?i ?r) 1)
                (increase (total-orders ?i) 1)
                (increase (total-cost) 1)
    )
)

(:action order-high
    :parameters (?r - retail ?i - industry)
    :precondition (and 
                        (connected ?i ?r)
    )
    :effect (and 
                (increase (received-orders ?i ?r) (max-capacity ?i))
                (increase (total-orders ?i) (max-capacity ?i))
                (increase (total-cost) (max-capacity ?i))
    )
)

; =================== DEMAND ===============================

(:action attend-montly-demand
    :parameters (?r - retail
                 ?i - industry)
    :precondition (and 
                        (>= (stock ?r ?i) (monthly-demand ?r ?i))
    )
    :effect (and 
                (decrease (stock ?r ?i) (monthly-demand ?r ?i))
                (increase (demand ?r ?i) 1)
            )
)

)