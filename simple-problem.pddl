(define (problem industry-side) 

(:domain supply-chain)

(:objects 
    walmart - retail
    procter - industry
)

;One industry with the objective of attend the demand of one retail
(:init
    (= (made-items procter) 0)
    (= (limit procter) 1)
    (not (limit-reached procter))
    (= (stock walmart procter) 0)
    (= (monthly-demand walmart procter) 1) ; walmart sells one procter item per month
    (= (demand walmart procter) 0)
)

; The goal of this problem is to generate a plan for Procter to deal with
; ONE demand of their products in the retail Walmart
(:goal (and
        (= (demand walmart procter) 1)
    )
)

)
