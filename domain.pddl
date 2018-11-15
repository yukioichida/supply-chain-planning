;Header and description
(define (domain supply-chain)

(:requirements :equality :typing :fluents)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    retail vendor
)

(:predicates
    (connected ?i - vendor ?r - retail) ; indicates whether a retail is a connection of an vendor
)

(:functions 
    (storage-limit ?i - vendor)
    (max-capacity ?i - vendor)
    (total-orders ?i - vendor)
    (received-orders ?i - vendor ?r - retail)
    (made-items ?i - vendor) ; items ready to the replenishment of retails stock
    (stock ?r - retail ?i - vendor) ; stock level of a retail given products of an vendor
    (demand ?r - retail ?i - vendor) ; quantity of demands that a retail should attend
    (monthly-demand ?r - retail ?i - vendor); quantity of itens of a vendor that a retail sells
    (total-cost)
)

; =================== PRODUCE ===============================

(:action produce-high
    :parameters (?i - vendor)
    :precondition (and 
                    (>= (total-orders ?i) (max-capacity ?i))
                    (< (made-items ?i) (- (storage-limit ?i) (max-capacity ?i)))
                )
    :effect (and 
        (increase (total-cost) (max-capacity ?i))
        (increase (made-items ?i) (max-capacity ?i))
        (decrease (total-orders ?i) (max-capacity ?i))
    )
)

(:action produce-low
    :parameters (?i - vendor)
    :precondition (and 
                    (>= (total-orders ?i) 1) ; produce only if have orders
                    (< (made-items ?i) (storage-limit ?i)) ; verify if this produce will reach the limit
                )
    :effect (and 
        (increase (made-items ?i) 1)
        (increase (total-cost) 1)
        (decrease (total-orders ?i) 1)
    )
)


; =================== REPLENISH ===============================

(:action replenish-high
    :parameters (?i - vendor
                 ?r - retail
                )
    :precondition (and 
                    (>= (made-items ?i) (max-capacity ?i))
                    (>= (received-orders ?i ?r) (max-capacity ?i))
                )
    :effect (and 
                (increase (stock ?r ?i) (max-capacity ?i))
                (decrease (made-items ?i) (max-capacity ?i))
                (decrease (received-orders ?i ?r) (max-capacity ?i))
    )
)

(:action replenish-low
    :parameters (?i - vendor
                 ?r - retail
                )
    :precondition (and 
                    (> (made-items ?i) 0)
                    (>= (received-orders ?i ?r) 1)
                )
    :effect (and 
                (increase (stock ?r ?i) 1)
                (decrease (made-items ?i) 1)
                (decrease (received-orders ?i ?r) 1)
    )
)

; =================== ORDER ===============================

(:action order-high
    :parameters (?r - retail ?i - vendor)
    :precondition (and 
                        (connected ?i ?r)
    )
    :effect (and 
                (increase (received-orders ?i ?r) (max-capacity ?i))
                (increase (total-orders ?i) (max-capacity ?i))
                (increase (total-cost) (max-capacity ?i))
    )
)

(:action order-low
    :parameters (?r - retail ?i - vendor)
    :precondition (and 
                        (connected ?i ?r)
    )
    :effect (and 
                (increase (received-orders ?i ?r) 1)
                (increase (total-orders ?i) 1)
                (increase (total-cost) 1)
    )
)
; =================== DEMAND ===============================

(:action attend-monthly-demand
    :parameters (?r - retail
                 ?i - vendor)
    :precondition (and 
                        (>= (stock ?r ?i) (monthly-demand ?r ?i))
    )
    :effect (and 
                (decrease (stock ?r ?i) (monthly-demand ?r ?i))
                (increase (demand ?r ?i) 1)
            )
)

)