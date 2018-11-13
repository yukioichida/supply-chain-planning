(define (problem industry-side2) (:domain supply-chain)
(:objects 
    walmart - retail
    walgreens - retail
    procter - industry
)

;One industry with the objective of attend the demand of one retail
(:init
    (= (made-items procter) 0)

    (= (limit procter) 2)
    (= (total-cost) 0)
    

    (= (stock walmart procter) 0)
    (= (monthly-demand walmart procter) 2) ; walmart sells one procter item per month
    (= (demand walmart procter) 0)

    (= (stock walgreens procter) 0)
    (= (monthly-demand walgreens procter) 2) ; walmart sells one procter item per month
    (= (demand walgreens procter) 0)
)

; The goal of this problem is to generate a plan for Procter to deal with
; ONE demand of their products in the retail Walmart
(:goal (and
        (= (demand walmart procter) 1)
        (= (demand walgreens procter) 1)
    )
)

; maximize does not work
(:metric minimize (total-cost))
)
